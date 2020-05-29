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
1. Use any of the [Configuration tools](xref:ConfigurationTools) capable of making HTTP requests to execute a POST command with the contents of that file to the following endpoint: `http://localhost:\<port>/api/v1/configuration/\<adapterId>/DataSource/`.

**Note:** The following example uses DNP3-1 as the adapter component name. For more information on how to add a component, see [System components configuration](xref:SystemComponentsConfiguration). The example also assumes that the default port number, 5590, is used. If you selected a different port number, replace it with that value. 

> curl -v -d `"@DataSource.config.json"` -H `"Content-Type: application/json" "http://localhost:5590/api/v1/configuration/DNP3-1/DataSource"` 

**Note:** After you have completed data source configuration, the next step is to configure data selection. Depending on your data source configuration, your data selection configuration may be pre-populated by discovery. For more information, see [OSIsoft Adapter for DNP3 data selection configuration](xref:OSIsoftAdapterForDNP3DataSelectionConfiguration) and [Discovery](xref:OSIsoftAdapterForDNP3PrinciplesOfOperation#discovery).

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
Port | Optional | number | TCP port that the outstations are listening on. Default is 20000.
MasterStationBehaviorId | Required | string | Must match the Id of one of the configurations in the MasterStationBehaviors list.
Outstations | Required | array | List of outstations that the adapter will connect to on the TCPChannel.

### Outstation Parameters
The following parameters may be used to configure each Outstation in the Outstations array within a TCP channel: 

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
Id | Required | string | Friendly identifier of the outstation. Must be unique among all Channels and Outstations. May be referenced by a data selection item. 
DNPAddress | Required | number | Address of the Outstation on the Channel. This is a 2 byte, unsigned integer. 
OutstationBehaviorId | Required | string | Must match the Id of one of the configurations in the OutstationBehaviors array.

## DNP3 data source examples

### Minimum configuration for a single outstation
The following example is a configuration for a single outstation on a single TCP channel. 
The optional configuration parameters have been omitted, so the default values will be used. 
With the default configuration, the adapter will accept unsolicited responses and perform an integrity scan every hour, potentially triggering [Discovery](xref:OSIsoftAdapterForDNP3PrinciplesOfOperation#discovery).  
For more information about the default configuration, reference the tables above. 
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
The following example is a configuration for two outstations that are on one channel and one outstation that is on a separate channel. 
Rather than using the default configurations, many configuration options are expressed here. 

There are two MasterStationBehaviors, one of which increases the data link layer timeout and retry count. 
This may be needed when operating with network conditions that are less than ideal. 
Any TCPChannel that references the master station behavior "poorNetworkConditions" will use these settings, while TCPChannels that reference "defaultMasterBehavior" will use the default settings. 

There are three OutstationBehaviors defined: "eventScans-integrityScan-noUnsolicited", "busyOutstation", and "class1Events". 

The behavior "eventScans-integrityScan-noUnsolicited" deviates from the default configuration options by disabling unsolicited responses and scanning for events every ten minutes. 
This type of configuration is useful if the outstation does not support unsolicited events, or maybe it is more efficient to scan for events periodically. 

The behavior "busyOutstation" deviates from the default configuration by increasing the application layer timeout, disabling the time sync, and disabling all integrity scans. 
Please note that the disabling the integrity scan will prevent discovery and event scans are disabled by default. 
With this configuration, the adapter will only collect data if it is configured to collect [static data](xref:OSIsoftAdapterForDNP3PrinciplesOfOperation#static-data).
This type of configuration is useful if the outstation is very busy. 
For instance, the adapter may not be the only master communicating with this outstation, so another master station is responsible for syncing the outstation's time and polling for events. 
In addition, an integrity scan may put too much burden on the outstation if there are a large number of points.

The behavior "class1Events" deviates from the default configuration by disabling unsolicited responses, only performing an integrity scan on startup, and only scanning for events from points assigned to class 1.
This configuration may be useful if the user is not interested in collecting data for points assigned to class 2 or class 3. 

There are two TCPChannels configured. One channel has two outstations configured. 
This channel might represent a connection to a DNP3 gateway at a substation. 
The other TCPChannel only contains one configured outstation. 
This might represent a DNP3 device that is in a remote location.

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

