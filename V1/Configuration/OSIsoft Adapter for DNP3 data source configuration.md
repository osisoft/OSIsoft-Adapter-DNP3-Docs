---
uid: OSIsoftAdapterForDNP3DataSourceConfiguration
---

# OSIsoft Adapter for DNP3 data source configuration
To use the DNP3 adapter, you must configure the adapter to collect data from one or more DNP3 compliant outstations. The adapter may make many TCP connections, by defining multiple TCP channels, and many connections to outstations, by defining multiple outstation configurations. 

## Configure DNP3 data source 
**Note:** You cannot modify DNP3 data source configurations manually. You must use the REST endpoints to add or edit the configuration.

Complete the following procedure to configure the DNP3 data source: 
1. Using any text editor, create a file that contains a DNP3 data source in JSON form.
    * For content structure, see [DNP3 data source Example](#dnp3-data-source-example).
    * For a table of all available parameters, see [DNP3 data source parameters](#dnp3-data-source-parameters). 
1. Save the file, for example, as *DataSource.config.json*. 
1. Use any of the [Configuration tools](./Configuration%20tools.html) capable of making HTTP requests to execute a POST command with the contents of that file to the following endpoint: `http://localhost:\<port>/api/v1/configuration/\<adapterId>/DataSource/`.

**Note:** The following example uses DNP3-1 as the adapter component name. For more information on how to add a component, see [System components congiguration](./System%20components%20configuration.html). The example also assumes that the default port number, 5590, is used. If you selected a different port number, replace it with that value. 

> curl -v -d `"@DataSource.config.json"` -H `"Content-Type: application/json" "http://localhost:5590/api/v1/configuration/DNP3-1/DataSource"` 

**Note:** After you have completed data source configuration, the next step is to configure data selection. Depending on your data source configuration, your data selection configuration may be pre-populated by discovery. For more information, see [OSIsoft Adapter for DNP3 data selection configuration](./OSIsoft%20Adapter%20for%20DNP3%20data%20selection%20configuration.html) and [Discovery](../OSIsoft%20Adapter%20for%20DNP3%20overview/OSIsoft%20Adapter%20for%20DNP3%20principles%20of%20operation.html#discovery).

## DNP3 data source schema
The full schema definition for the DNP3 data source configuration is in the DNP3_DataSource_schema.json file which is located:
 
OS | Directory
-----------|----------
Windows | %ProgramFiles%\OSIsoft\Adapters\DNP3\Schemas
Linux | /opt/OSIsoft/Adapters/DNP3/Schemas

## DNP3 data source parameters
Many of the data source configuration parameters are split into four categories: 
* Parameters that define the adapter's behavior as a DNP3 master station are defined as *__MasterStationBehaviors__*
* Parameters that define the general behaviors of the DNP3 outstations are defined as *__OutstationBehaviors__*
* Parameters that define the connection information for a TCP channel are defined as *__TCPChannels__*
* Parameters that define the connection information for a specific outstation are defined as *__Outstations__*

The following parameters may be used to configure a DNP3 data source: 

| Parameter | Required | Type | Description |
| --------- | -------- | ---- | ----------- |
| MasterStationBehaviors | Required | array | List of MasterStationBehavior objects that define the adapter's behavior as a DNP3 master station. See [MasterStationBehavior Parameters](#masterstationbehavior-parameters) for more info. |
| OutstationBehaviors | Required | array | List of OutstationBehavior objects that define general behaviors for DNP3 outstations. See [OutstationBehavior Parameters](#outstationbehavior-parameters) for more info. |
| TCPChannels | Required | array | List of TCPChannel objects that define TCP connection information. See [TCPChannel Parameters](#tcpchannel-parameters) for more info.|
| StreamIdPrefix | Optional | string | Specifies what prefix is used for Stream IDs. Note: An empty string means no prefix will be added to the Stream IDs. Specifying 'null' or omitting this parameter will result in the ComponentID followed by a dot character being used to prefix the Stream IDs. |
| DefaultStreamIdPattern | Optional | string | Specifies the default Stream ID pattern to use. Possible parameters: {OutstationId}, {DNPPointType}, {Index}, {Group}, and {Variation}. An empty or `null` value will result in "{OutstationId}.{DNPPointType}.{Index}" |

### MasterStationBehavior Parameters
The following parameters may be used to configure each MasterStationBehavior in the MasterStationBehaviors array:

Parameter | Required | Type | Description 
--------- | -------- | ---- | -----------
Id | Required | string | Friendly identifier for the configuration. Must be unique among all MasterStationBehaviors.
MasterAddress | Required | number | Address that the Adapter will use when communicating on a Channel. Must be an available address on the Channel, Outstations may need to be configured to accept connections from this address. This is a 2 byte, unsigned integer.
DataLinkLayerTimeout | Optional | string | Period that should be long enough for a Data Link Layer frame to be transmitted. "HH:MM:SS.##" format. Default is 3 seconds.
DataLinkLayerRetries | Optional | number | Number of times that the adapter will re-send a data link frame before resetting the link. Default is 2. 

### OutstationBehavior Parameters 
The following parameters may be used to configure each OutstationBehavior in the OutstationBehaviors array:

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
Id | Required | string | Friendly identifier for the configuration. Must be unique among all OutstationBehaviors.
ApplicationLayerTimeout | Optional | string |Period that should be long enough for an entire Application Layer message to be transmitted. "HH:MM:SS.##" format. Default is 3 seconds.
EnableUnsolicited | Optional | boolean | If true, the adapter will accept unsolicited messages from an outstation that is configured to send unsolicited event data. Default is true.
EnableTimeSync | Optional | boolean | If true, the adapter will write the current time to an outstation that indicates "NeedTime" via the internal indication bits. Default is true.
IntegrityScanOnStartup | Optional | boolean | If true, the adapter will perform an integrity scan whenever the adapter or outstation is restarted. Default is true.
IntegrityScanOnEventBufferOverflow | Optional | boolean | If true, the adapter will perform an integrity scan whenever the outstation's event buffers overflow. Default is true.
IntegrityScanPeriod | Optional | string | Frequency of integrity scans. Set to "00:00:00" for no periodic integrity scans. "HH:MM:SS.##" format. Default is 1 hour.
EventClasses | Optional | array | List of event classes that the adapter will scan during an event scan. Default is [1, 2, 3], meaning all event classes. 
EventScanPeriod | Optional | string | Frequency of event scans. "HH:MM:SS.##" format. Set to "00:00:00" for no event scans. Default is "00:00:00"

### TCPChannel Parameters
The following parameters may be used to configure each Thannel in the TCPChannels array: 

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
HostnameOrIpAddress | Required | string | IPv4 address or hostname that can be resolved to an IPv4 address. The adapter will establish a connection to this address.
Port | Required | number | TCP port that the outstations are listening on. 
MasterStationBehaviorId | Required | string | Must match the Id of one of the configurations in the MasterStationBehaviors list.
Outstations | Required | array | List of outstations that the adapter will connect to on the TCPChannel.

### Outstation Parameters
The following parameters may be used to configure each Outstation in the Outstations array within a TCP channel: 

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
Id | Required | string | Friendly identifier of the outstation. Must be unique among all Channels and Outstations. May be referenced by a data selection item. 
DNPAddress | Required | number | Address of the Outstation on the Channel. This is a 2 byte, unsigned integer. 
OutstationBehaviorId | Required | string | Must match the Id of one of the configurations in the OutstationBehaviors array.