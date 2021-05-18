---
uid: PIAdapterForDNP3DataSourceConfiguration
---

# Data source

To use the DNP3 adapter, you must configure the adapter to collect data from one or more DNP3 compliant outstations. The adapter can make many TCP connections by defining multiple TCP channels, and many connections to outstations by defining multiple outstation configurations.

## Configure DNP3 data source

Complete the following steps to configure a DNP3 data source. Use the `PUT` method in conjunction with the `api/v1/configuration/<ComponentId>/DataSource` REST endpoint to initialize the configuration.

1. Using a text editor, create an empty text file.

2. Copy and paste an example configuration for a DNP3 data source into the file.

    For sample JSON, see [DNP3 data source examples](#dnp3-data-source-examples).

3. Update the example JSON parameters for your environment.

    For a table of all available parameters, see [DNP3 data source parameters](#dnp3-data-source-parameters).

4. Save the file. For example, as `ConfigureDataSource.json`.

5. Open a command line session. Change directory to the location of `ConfigureDataSource.json`.

6. Enter the following cURL command (which uses the `PUT` method) to initialize the data source configuration.

    ```bash
    curl -d "@ConfigureDataSource.json" -H "Content-Type: application/json" -X PUT "http://localhost:5590/api/v1/configuration/DNP3-1/DataSource"
    ```

    **Notes:**
  
    * If you installed the adapter to listen on a non-default port, update `5590` to the port number in use.
    * If you use a component ID other than `DNP3-1`, update the endpoint with your chosen component ID.
    * For a list of other REST operations you can perform, like updating or deleting a data source configuration, see [REST URLs](#rest-urls).
    <br/>
    <br/>

7. Configure data selection. Depending on your data source configuration, your data selection configuration can be pre-populated by discovery. For more information, see [PI Adapter for DNP3 data selection configuration](xref:PIAdapterForDNP3DataSelectionConfiguration) and [Discovery](xref:PIAdapterForDNP3PrinciplesOfOperation#discovery).

## DNP3 data source schema

The full schema definition for the DNP3 data source configuration is in the `DNP3_DataSource_schema.json` file located in one of the following folders:

Windows: `%ProgramFiles%\OSIsoft\Adapters\DNP3\Schemas`

Linux: `/opt/OSIsoft/Adapters/DNP3/Schemas`

## DNP3 data source parameters

Many of the data source configuration parameters are split into four categories:

* Parameters that define the adapter's behavior as a DNP3 master station are defined as **MasterStationBehaviors**.
* Parameters that define the general behaviors of the DNP3 outstations are defined as **OutstationBehaviors**.
* Parameters that define the connection information for a TCP channel are defined as **TCPChannels**.
* Parameters that define the connection information for a specific outstation are defined as **Outstations**.

The following parameters are available to configure a DNP3 data source:

| Parameter | Required | Type | Description |
| --------- | -------- | ---- | ----------- |
| **MasterStationBehaviors** | Required | `array` | List of **MasterStationBehavior** objects that specifies the adapter's behavior as a DNP3 master station. <br><br> For additional information, see [MasterStationBehavior Parameters](#masterstationbehavior-parameters). |
| **OutstationBehaviors** | Required | `array` | List of **OutstationBehavior** objects that specifies general behaviors for DNP3 outstations. <br><br> For additional information, see [OutstationBehavior Parameters](#outstationbehavior-parameters). |
| **TCPChannels** | Required | `array` | List of **TCPChannel** objects that specifies TCP connection information. <br><br> For additional information, see [TCPChannel Parameters](#tcpchannel-parameters).|
| **StreamIdPrefix** | Optional | `string` | Specifies what prefix is used for stream IDs. The naming convention is `{StreamIdPrefix}{StreamId}`.An empty string means no prefix will be added to the stream IDs and names. A `null` value defaults to **ComponentID** followed by a period.<br><br>Example: `DNP3-1.{OutstationId}.{DNPPointType}.{Index}`<br><br>**Note:** If you change the **StreamIdPrefix** of a configured adapter, for example when you delete and add a data source, you need to restart the adapter for the changes to take place. New streams are created on adapter restart and pre-existing streams are no longer updated. 
| **DefaultStreamIdPattern** | Optional | `string` | Specifies the default stream ID pattern to use.  An empty or `null` value results in the default value. Possible parameters: `{OutstationId}`,`{DNPPointType}`, `{Index}`, `{Group}`, and `{Variation}`.<br><br>Allowed value: any string<br>Default value: `{OutstationId}.{DNPPointType}.{Index}`. |

### MasterStationBehavior parameters

The following parameters are available to configure each **MasterStationBehavior** in the **MasterStationBehaviors** array:

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
**Id** | Required | `string` | Friendly identifier for the configuration. Must be unique among all **MasterStationBehaviors**.
**MasterAddress** | Required | `number` | Address that the adapter uses when communicating on a channel. Must be an available address on the channel. **Outstations** can be configured to accept connections from this address. This is a 2 byte, unsigned integer.
**DataLinkLayerTimeout** | Optional | `string` | Period long enough for a Data Link Layer frame to be transmitted represented in `hhh:mm:ss.fff` format.<br><br>Default value: `00:00:03` for `3` seconds
**DataLinkLayerRetries** | Optional | `number` | Number of times that the adapter re-sends a data link frame before resetting the link.<br><br> Default value: `2`

### OutstationBehavior parameters

The following parameters are available to configure each **OutstationBehavior** in the **OutstationBehaviors** array:

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
**Id** | Required | `string` | Friendly identifier for the configuration. Must be unique among all **OutstationBehaviors**.
**ApplicationLayerTimeout** | Optional | `string` |Period long enough for an entire Application Layer message to be transmitted represented in `hh:mm:ss.fff` format.<br><br>Default value: `00:00:03` for `3` seconds
**EnableUnsolicited** | Optional | `boolean` | If true, the adapter accepts unsolicited messages from an outstation that is configured to send unsolicited event data.<br><br>Allowed value: `true` or `false`<br>Default value:`true`
**EnableTimeSync** | Optional | `boolean` | If true, the adapter writes the current time to an outstation that indicates "NeedTime" through the internal indication bits.<br><br>Allowed value: `true` or `false`<br>Default value:`true`
**IntegrityScanOnStartup** | Optional | `boolean` | If true, the adapter performs an integrity scan whenever the adapter or outstation is restarted.<br><br>Allowed value: `true` or `false`<br>Default value:`true`
**IntegrityScanOnEventBufferOverflow** | Optional | `boolean` | If true, the adapter performs an integrity scan whenever the outstation's event buffers overflow.<br><br>Allowed value: `true` or `false`<br>Default value:`true`
**IntegrityScanPeriod** | Optional | `string` | Frequency of integrity scans. Set to `00:00:00` for no periodic integrity scans represented in `hh:mm:ss.fff` format.<br><br>Default value: `01:00:00` for `1` hour
**EventClasses** | Optional | `array` | List of event classes that the adapter scans during an event scan. Default is `[1, 2, 3]`, meaning all event classes.
**EventScanPeriod** | Optional | `string` | Frequency of event scans represented in `hh:mm:ss.fff` format. Set to `00:00:00` for no event scans.<br><br>Default value: `00:00:00`

### TCPChannel parameters

The following parameters are available to configure each channel in the **TCPChannels** array:

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
**HostNameOrIpAddress** | Required | `string` | IPv4 address or hostname that can be resolved to an IPv4 address. The adapter establishes a connection to this address.
**Port** | Optional | `number` | TCP port that the outstations are listening on.<br><br>Default value:`20000`
**MasterStationBehaviorId** | Required | `string` | Must match the **Id** of one of the configurations in the **MasterStationBehaviors** list.
**Outstations** | Required | `array` | List of outstations that the adapter connects to on the **TCPChannel**. <Br> **Note:** A **TCPChannel** is uniquely identified by the combination of its `HostNameOrIPAddress` and `Port` properties. For valid configuration, each **TCPChannel** must have a unique combination of these properties.

### Outstation parameters

The following parameters are available to configure each **Outstation** in the **Outstations** array within a **TCPChannel**:

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
**Id** | Required | `string` | Friendly identifier of the outstation. Must be unique among all channels and **Outstations**. Can be referenced by a data selection item.
**DNPAddress** | Required | `number` | Address of the **Outstation** on the channel. This is a 2 byte, unsigned integer.
**OutstationBehaviorId** | Required | `string` | Must match the `Id` of one of the configurations in the **OutstationBehaviors** array.

## DNP3 data source examples

### Minimum configuration for a single outstation

The following example is a configuration for a single outstation on a single TCP channel. The optional configuration parameters have been omitted, so the default values are used. With the default configuration, the DNP3 adapter accepts unsolicited responses and perform an integrity scan every hour, potentially triggering [Discovery](xref:PIAdapterForDNP3PrinciplesOfOperation#discovery). For more information about the default configuration, reference the tables above.

```json
{
    "masterStationBehaviors": [
        {
            "id": "masterBehavior1",
            "masterAddress": 1
        }
    ],
    "outstationBehaviors": [
        {
            "id": "outstationBehavior1"
        }
    ],
    "tcpChannels": [
        {
            "masterStationBehaviorId": "masterBehavior1",
            "hostNameOrIpAddress": "outstation1.scadanetwork.int",
            "outstations": [
                {
                    "id": "Outstation1",
                    "dnpAddress": 10,
                    "outstationBehaviorId": "outstationBehavior1"
                }
            ]
        }
    ]
}
```

### Example configuration for multiple outstations

The following example is a configuration for two outstations that are on one channel and one outstation that is on a separate channel. Rather than using the default configurations, many configuration options are expressed here.

There are two **MasterStationBehaviors**, one of which increases the data link layer timeout and retry count. This can be needed when operating with network conditions that are less than ideal.  Any **TCPChannel** that references the master station behavior `poorNetworkConditions` uses these settings, while **TCPChannels** that reference `defaultMasterBehavior` uses the default settings.

There are three **OutstationBehaviors**: `eventScans-integrityScan-noUnsolicited`, `busyOutstation`, and `class1Events`:

The behavior `eventScans-integrityScan-noUnsolicited` deviates from the default configuration options by disabling unsolicited responses and scanning for events every 10 minutes. This type of configuration is useful if the outstation does not support unsolicited events or it may be more efficient to scan for events periodically.

The behavior `busyOutstation` deviates from the default configuration by increasing the application layer timeout, disabling the time sync, and disabling all integrity scans.

**Note:** Disabling the integrity scan prevents discovery. Event scans are disabled by default.

With this configuration, the DNP3 adapter only collects data if it is configured to collect [static data](xref:PIAdapterForDNP3PrinciplesOfOperation#static-data). This type of configuration is useful if the outstation is very busy. For instance, the adapter can not be the only master communicating with this outstation, so another master station is responsible for syncing the outstation's time and polling for events. In addition, an integrity scan can put too much burden on the outstation if there are a large number of points.

The behavior `class1Events` deviates from the default configuration by disabling unsolicited responses, only performing an integrity scan on startup, and only scanning for events from points assigned to class 1. This configuration is useful if you are not interested in collecting data for points assigned to class 2 or class 3.

There are two **TCPChannels** configured. One channel has two outstations configured. This channel might represent a connection to a DNP3 gateway at a substation. The other **TCPChannel** only contains one configured outstation. This might represent a DNP3 device that is in a remote location.

```json
{
    "masterStationBehaviors": [
        {
            "id": "poorNetworkConditions",
            "masterAddress": 1,
            "dataLinkLayerTimeout": "00:00:05",
            "dataLinkLayerRetries": 5
        },
        {
            "id": "defaultMasterBehavior",
            "masterAddress": 1
        }
    ],
    "outstationBehaviors": [
        {
            "id": "eventScans-integrityScan-noUnsolicited",
            "enableUnsolicited": false,
            "EventClasses": [
                1,
                2,
                3
            ],
            "eventScanPeriod": "00:10:00"
        },
        {
            "id": "busyOutstation",
            "applicationLayerTimeout": "00:00:30",
            "enableTimeSync": false,
            "integrityScanOnStartup": false,
            "integrityScanOnEventBufferOverflow": false,
            "integrityScanPeriod": "00:00:00"
        },
        {
            "id": "class1Events",
            "applicationLayerTimeout": "00:00:03",
            "enableUnsolicited": false,
            "integrityScanOnStartup": true,
            "integrityScanOnEventBufferOverflow": false,
            "integrityScanPeriod": "00:00:00",
            "EventClasses": [ 1 ],
            "eventScanPeriod": "00:10:00"
        }
    ],
    "tcpChannels": [
        {
            "masterStationBehaviorId": "defaultMasterBehavior",
            "hostNameOrIpAddress": "substation1.scadanetwork.int",
            "outstations": [
                {
                    "id": "outstation10",
                    "dnpAddress": 10,
                    "outstationBehaviorId": "eventScans-integrityScan-noUnsolicited"
                },
                {
                    "id": "outstation100",
                    "dnpAddress": 100,
                    "outstationBehaviorId": "busyOutstation"
                }
            ]
        },
        {
            "masterStationBehaviorId": "poorNetworkConditions",
            "hostNameOrIpAddress": "outstation11.scadanetwork.int",
            "port": 20001,
            "outstations": [
                {
                    "id": "Outstation11",
                    "dnpAddress": 11,
                    "outstationBehaviorId": "class1Events"
                }
            ]
        }
    ]
}
```
## REST URLs

| Relative URL | HTTP verb | Action |
|--|--|--|
| api/v1/configuration/\<ComponentId\>/DataSource | `GET` | Retrieves the data source configuration. |
| api/v1/configuration/\<ComponentId\>/DataSource | `POST` | Creates the data source configuration. The adapter starts collecting data after the following conditions are met:<br/><br/>&bull; The data source configuration `POST` request is received.<br/>&bull; A data selection configuration is active. |
| api/v1/configuration/\<ComponentId\>/DataSource | `PUT` | Configures or updates the data source configuration. Overwrites any active data source configuration. If no configuration is active, the adapter starts collecting data after the following conditions are met:<br/><br/>&bull; The data source configuration `PUT` request is received.<br/>&bull; A data selection configuration is active. |
| api/v1/configuration/\<ComponentId\>/DataSource | `DELETE` | Deletes the data source configuration. After the request is received, the adapter stops collecting data. |

**Note:** Replace \<ComponentId\> with the Id of your DNP3 component. For example, DNP3-1.
