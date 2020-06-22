---
uid: PIAdapterForDNP3PrinciplesOfOperation
---

# PI Adapter for DNP3 principles of operation

## Connectivity and Interoperability
The DNP3 Adapter may connect to one or more DNP3 compliant outstations via TCP/IP connections. The total number of outstations that the DNP3 Adapter may connect to will vary across different installation environments.  

The DNP3 Adapter is designed to operate with Level 1 (DNP3–L1) compliance, which defines minimum requirements for all DNP3 compliant devices. 
However, the adapter does make use of some Level 2, Level 3, and Level 4 functions. Some DNP3 compliant devices may not support these same features.  
Any functionality described in this documentation that is not required for Level 1 compliance will be noted as such. 
Please check the outstation documentation prior to using these features, as the adapter will need to be configured to only use the supported features of the outstation.  

## Adapter Configuration

In order for the DNP3 Adapter to start data collection, you need to configure the adapter by defining the following:

- Data source: Provide the information required to connect to your DNP3 compliant outstations. 
- Data selection: Select the DNP points on the outstations you want the adapter to collect data from.
- Logging: Set up the logging attributes to manage the adapter logging behavior.

For more infomation, see [PI Adapter for DNP3 data source configuration](xref:PIAdapterForDNP3DataSourceConfiguration) and [PI Adapter for DNP3 data selection configuration](xref:PIAdapterForDNP3DataSelectionConfiguration).

## Stream creation
The DNP3 adapter creates types at startup. One stream is created for every selected DNP point represented by an item in the data selection configuration. Each stream contains two properties:

| Property name | Data type | Description
| ------------- | --------- | -----------
| `Timestamp` | DateTime | Timestamp of the value update for the DNP point. 
| `Value` | Specified on the data selection configuration | Value of the DNP point.

Certain metadata are sent with each stream created. Metadata common for every adapter type are

- **ComponentType**: Specifies the type of adapter, for example _DNP3_
- **ComponentId**: Specifies the data source, for example _DNP3_1_

Each stream created for a given DNP point has a unique identifier or "Stream ID". If you specify a custom stream ID for the DNP point in data selection configuration, the adapter uses that stream ID to create the stream. 
If the stream ID is not specified, the adapter will use the DefaultStreamIdPattern in the data source configuration to determine the stream ID. 

### Discovery
The DNP3 adapter can discover points on your DNP3 outstation by performing an [*integrity scan*](#Integrity-scans). 
Discovery will populate your data selection configuration with items that represent points on the outstation. 
These items will default as unselected, so the user may make changes to these items before selecting them. 
The adapter can only discover points that are assigned to Class 0, Class 1, Class 2, or Class 3 on the outstation.
Discovery may be expensive in terms of bandwidth and outstation resources, so the adapter will only perform discovery for an outstation when the following criteria is met: 

- The outstation is configured in the data source configuration.
- The adapter is configured to perform an integrity scan for that outstation. 
- The data selection configuration contains no items that correlate to that outstation, selected or unselected.

To discover a new outstation, simply add the outstation to the data source configuration and configure an integrity scan to run periodically or on startup. 
The adapter will use the first integrity scan as a means for discovery. 
To configure a new outstation without triggering a discovery, you can add one or more selection items to correspond with the outstation. 
The items may be selected or unselected. 
Alternatively, you can configure the outstation behavior so that no integrity scan will be performed. Without an integrity scan, discovery will not be possible. 

## Data collection
The DNP3 adapter can collect two different types of data from DNP3 compliant outstations: *static* data and *event* data.

### Static data
The DNP3 specification defines static data as the current value of a DNP point at the time of a request. 
The DNP3 adapter may be configured to request static data by polling the outstation(s) for a range of points that share an object group and variation,
 which are configured in the data selection configuration. 
Static data will be reported with the current time of the adapter machine. 
When polling for static data at predefined rate, it is possible that quickly changing data may be missed by the adapter. 
It is also possible that the adapter will receive multiple values representing the same event but with different timestamps. 

The adapter makes a request for the current value of specific points as configured in the Data Selection configuration file. 
The adapter will request this data via a range scan, which will request the static data for a range of point indices that share a group and variation,
 as configured in the data selection configuration.
The outstation should report the current value of each point, but the outstation is not required to report using the requested object variation. 
If the outstation responds with a different variation than what the adapter has requested, the adapter will still send the data it receives.
This could lead to differences in the reported value versus what is expected in terms of precision and status. 

Support for requesting static data for DNP3 points via a range scan is at least a Level 2 function, and some groups and variations may be considered L3 or L4 functionality.
Because of this, it is important to verify that your outstation supports this functionality before configuring the adapter to collect data in this manner. 
Some DNP3-L1 compliant outstations may optionally support this type of scan. 

### Event data
The DNP3 specification defines event data as the information that is retained regarding an event. 
An event is defined by the DNP3 specification as the occurrence of something significant happening. 
What constitutes an event may vary depending on the implementation of the outstation. 
Typically, an event will result in a value change for a DNP point,
 although it is possible for an event to occur that does not change the value of any point on the outstation. 
Event data is saved at the outstation(s) and should be kept until the adapter confirms that it has received the event object.  
The event object is the description of the event that the adapter should receive from the outstation(s). 
The event object may contain the value, time, and status code relating to the event and corresponding point. 
The exact information contained in the object will be dependent on both the point type and variation,
 which are defined in the DNP3 specification.  

DNP3 events belong to one of three different classes of data: *Class 1*, *Class 2*, or *Class 3*. 
These event classes may be used to group events by priority,
 though neither the DNP3 adapter nor the DNP3 specification assign significance to the three event classes. 

According to the DNP3 specification, all DNP3 – L1 compliant outstations shall accept read requests for event class data.  

#### Event Scans
The adapter may be configured to request event data via an *event scan*. 
During an *event scan*, the adapter will poll the outstation(s) for the event data from each of the configured event classes. 
The event classes and the polling interval may be configured in the [data source configuration](xref:PIAdapterForDNP3DataSourceConfiguration#OutstationBehavior-Parameters).

*Event scans* offer several advantages over polling for static data. 
When polling for static data, it is possible to miss value changes for points on the outstation;
 however, *event scans* will ensure that each outstation reports every event to the adapter. 
Similarly, even when polling quickly, some events could be missed if they do not change the value of the DNP point. 
If bandwidth is a concern, the adapter may make efficient use of the network by only requesting event data. 
When polling for static data, the outstation may report unchanging data unnecessarily, whereas *event scans* should only return new events. 
It is important to configure the adapter to perform Event Scans at an interval that is not long enough to allow the outstations’ event buffers to become full. 
Refer to the documentation for each specific outstation to determine what constitutes an event and how much time it will take before the buffer becomes full. 

#### Unsolicited Events
In addition to the *event scans* above, the adapter may be configured to receive *unsolicited* responses containing event data. 
An unsolicited response is a message sent from an outstation that the adapter did not explicitly request. 

If the adapter is configured to receive unsolicited data, outstations that support sending unsolicited data should report event data to the adapter as it occurs. 
This could eliminate the need for the adapter to poll the outstation(s) for data. 
The decision to configure the adapter to receive unsolicited data, or to perform Event Scans should be carefully considered.  

### Integrity Scans
The DNP3 adapter can be configured to perform an *integrity scan* on startup,
 when the outstation's event buffer overflows, and/or at a defined interval.
During an *integrity scan*, the adapter will poll the outstation(s) for events,
 then the current value of all points that are assigned to one of the event classes (or class 0).
The adapter performs an integrity scan by polling Object Group 60.
If bandwidth or outstation performance is a concern, carefully consider the value of an integrity scan, as the outstation may respond with data for many more points than the adapter is configured to collect data for. 
The adapter will simply discard any data that it receives without a corresponding data selection item. 
To retrieve the current value of any points not assigned to an event class, the adapter will need to perform a *static scan*.
