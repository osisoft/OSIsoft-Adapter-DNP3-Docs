---
uid: PIAdapterForDNP3DataSourceConfiguration
---

# PI Adapter for DNP3 data source configuration

To use the DNP3 adapter, you must configure the adapter to collect data from one or more DNP3 compliant outstations. The adapter may make many TCP connections by defining multiple TCP channels, and many connections to outstations by defining multiple outstation configurations.

## Configure DNP3 data source

**Note:** You cannot modify DNP3 data source configurations manually. You must use the REST endpoints to add or edit the configuration.

Complete the following steps to configure the DNP3 data source:

1. Use a text editor to create a file that contains a DNP3 data source in JSON format.
    * For content structure, see [DNP3 data source examples](#dnp3-data-source-examples).
    * For a table of all available parameters, see [DNP3 data source parameters](#dnp3-data-source-parameters).
1. Save the file. For example, `DataSource.config.json`.
1. Use any of the [Configuration tools](xref:ConfigurationTools) capable of making HTTP requests to run a `POST` command with the contents of the file to the following endpoint: `http://localhost:\<port>/api/v1/configuration/\<adapterId>/DataSource/`.

   **Note:** The following example uses DNP3-1 as the adapter component name. For more information on how to add a component, see [System components configuration](xref:SystemComponentsConfiguration).

   `5590` is the default port number. If you selected a different port number, replace it with that value.

   Example using `curl`:

   **Note:** Run this command from the same directory where the file is located.

   ```bash
    curl -v -d `"@DataSource.config.json"` -H `"Content-Type: application/json" "http://localhost:5590/api/v1/configuration/DNP3-1/DataSource"`
    ```

**Note:** After you complete data source configuration, the next step is to configure data selection. Depending on your data source configuration, your data selection configuration may be pre-populated by discovery. For more information, see [PI Adapter for DNP3 data selection configuration](xref:PIAdapterForDNP3DataSelectionConfiguration) and [Discovery](xref:PIAdapterForDNP3PrinciplesOfOperation#discovery).

## DNP3 data source schema

The full schema definition for the DNP3 data source configuration is in the `DNP3_DataSource_schema.json` file located in one of the following folders:

Windows: `%ProgramFiles%\OSIsoft\Adapters\DNP3\Schemas`

Linux: `/opt/OSIsoft/Adapters/DNP3/Schemas`

## DNP3 data source parameters

Many of the data source configuration parameters are split into four categories:

* Parameters that define the adapter's behavior as a DNP3 master station are defined as **MasterStationBehaviors**
* Parameters that define the general behaviors of the DNP3 outstations are defined as **OutstationBehaviors**
* Parameters that define the connection information for a TCP channel are defined as **TCPChannels**
* Parameters that define the connection information for a specific outstation are defined as **Outstations**

The following parameters may be used to configure a DNP3 data source:

| Parameter | Required | Type | Description |
| --------- | -------- | ---- | ----------- |
| **MasterStationBehaviors** | Required | `array` | List of **MasterStationBehavior** objects that define the adapter's behavior as a DNP3 master station. <br><br> For additional information, see [MasterStationBehavior Parameters](#masterstationbehavior-parameters). |
| **OutstationBehaviors** | Required | `array` | List of **OutstationBehavior** objects that define general behaviors for DNP3 outstations. <br><br> For additional information, see [OutstationBehavior Parameters](#outstationbehavior-parameters). |
| **TCPChannels** | Required | `array` | List of **TCPChannel** objects that define TCP connection information. <br><br> For additional information, see [TCPChannel Parameters](#tcpchannel-parameters).|
| **StreamIdPrefix** | Optional | `string` | Specifies what prefix is used for stream IDs. Specifying `null` or omitting this parameter results in the **ComponentID** followed by a dot character being used to prefix the stream IDs. <br>**Note:** An empty string means no prefix is added to the stream IDs. |
| **DefaultStreamIdPattern** | Optional | `string` | Specifies the default stream ID pattern to use. Possible parameters: `{OutstationId}`,`{DNPPointType}`, `{Index}`, `{Group}`, and `{Variation}`. An empty or `null` value results in `{OutstationId}.{DNPPointType}.{Index}`. |

### MasterStationBehavior parameters

The following parameters may be used to configure each **MasterStationBehavior** in the **MasterStationBehaviors** array:

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
**Id** | Required | `string` | Friendly identifier for the configuration. Must be unique among all **MasterStationBehaviors**.
**MasterAddress** | Required | `number` | Address that the adapter uses when communicating on a channel. Must be an available address on the Channel, **Outstations** may need to be configured to accept connections from this address. This is a 2 byte, unsigned integer.
**DataLinkLayerTimeout** | Optional | `string` | Period long enough for a Data Link Layer frame to be transmitted. "HH:MM:SS.##" format. The default value is `3` seconds.
**DataLinkLayerRetries** | Optional | `number` | Number of times that the adapter re-sends a data link frame before resetting the link. The default value is `2`.

### OutstationBehavior parameters

The following parameters may be used to configure each **OutstationBehavior** in the **OutstationBehaviors** array:

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
**Id** | Required | `string` | Friendly identifier for the configuration. Must be unique among all **OutstationBehaviors**.
**ApplicationLayerTimeout** | Optional | `string` |Period long enough for an entire Application Layer message to be transmitted. `HH:MM:SS.##` format. The default value is `3` seconds.
**EnableUnsolicited** | Optional | `boolean` | If true, the adapter accepts unsolicited messages from an outstation that is configured to send unsolicited event data. The default value is `true`.
**EnableTimeSync** | Optional | `boolean` | If true, the adapter writes the current time to an outstation that indicates "NeedTime" through the internal indication bits. The default value is `true`.
**IntegrityScanOnStartup** | Optional | `boolean` | If true, the adapter performs an integrity scan whenever the adapter or outstation is restarted. The default value is `true`.
**IntegrityScanOnEventBufferOverflow** | Optional | `boolean` | If true, the adapter performs an integrity scan whenever the outstation's event buffers overflow. The default value is `true`.
**IntegrityScanPeriod** | Optional | `string` | Frequency of integrity scans. Set to `00:00:00` for no periodic integrity scans. `HH:MM:SS.##` format. The default value is `1` hour.
**EventClasses** | Optional | `array` | List of event classes that the adapter scans during an event scan. Default is `[1, 2, 3]`, meaning all event classes.
**EventScanPeriod** | Optional | `string` | Frequency of event scans. `HH:MM:SS.##` format. Set to `00:00:00` for no event scans. The default value is `00:00:00`.

### TCPChannel parameters

The following parameters may be used to configure each channel in the **TCPChannels** array:

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
**HostNameOrIpAddress** | Required | `string` | IPv4 address or hostname that can be resolved to an IPv4 address. The adapter establishes a connection to this address.
**Port** | Optional | `number` | TCP port that the outstations are listening on. Default is `20000`.
**MasterStationBehaviorId** | Required | `string` | Must match the **Id** of one of the configurations in the **MasterStationBehaviors** list.
**Outstations** | Required | `array` | List of outstations that the adapter connects to on the **TCPChannel**. <Br> **Note:** A **TCPChannel** is uniquely identified by the combination of its `HostNameOrIPAddress` and `Port` properties. For valid configuration, each **TCPChannel** must have a unique combination of these properties.

### Outstation parameters

The following parameters may be used to configure each **Outstation** in the **Outstations** array within a **TCPChannel**:

Parameter | Required | Type | Description
--------- | -------- | ---- | -----------
**Id** | Required | `string` | Friendly identifier of the outstation. Must be unique among all channels and **Outstations**. May be referenced by a data selection item.
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

There are two **MasterStationBehaviors**, one of which increases the data link layer timeout and retry count. This may be needed when operating with network conditions that are less than ideal.  Any **TCPChannel** that references the master station behavior `poorNetworkConditions` uses these settings, while **TCPChannels** that reference `defaultMasterBehavior` uses the default settings.

There are three **OutstationBehaviors**: `eventScans-integrityScan-noUnsolicited`, `busyOutstation`, and `class1Events`:

The behavior `eventScans-integrityScan-noUnsolicited` deviates from the default configuration options by disabling unsolicited responses and scanning for events every 10 minutes. This type of configuration is useful if the outstation does not support unsolicited events, or maybe it is more efficient to scan for events periodically.

The behavior `busyOutstation` deviates from the default configuration by increasing the application layer timeout, disabling the time sync, and disabling all integrity scans.

**Note:** Disabling the integrity scan prevents discovery and event scans are disabled by default.

With this configuration, the DNP3 adapter only collects data if it is configured to collect [static data](xref:PIAdapterForDNP3PrinciplesOfOperation#static-data). This type of configuration is useful if the outstation is very busy. For instance, the adapter may not be the only master communicating with this outstation, so another master station is responsible for syncing the outstation's time and polling for events. In addition, an integrity scan may put too much burden on the outstation if there are a large number of points.

The behavior `class1Events` deviates from the default configuration by disabling unsolicited responses, only performing an integrity scan on startup, and only scanning for events from points assigned to class 1. This configuration may be useful if you are not interested in collecting data for points assigned to class 2 or class 3.

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
