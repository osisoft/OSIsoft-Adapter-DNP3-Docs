---
uid: PIAdapterForDNP3DataSelectionConfiguration
---

# PI Adapter for DNP3 data selection configuration

In addition to the data source configuration, you need to provide a data selection configuration to specify the data you want the DNP3 adapter to collect from your outstations.

Depending on your data source configuration, your data selection configuration may be pre-populated by discovery. For more information, see [PI Adapter for DNP3 data source configuration](xref:PIAdapterForDNP3DataSourceConfiguration) and [Discovery](xref:PIAdapterForDNP3PrinciplesOfOperation#discovery).

## Configure DNP3 data selection

You cannot modify DNP3 data selection configurations manually. You must use the REST endpoints to add or edit the configuration.

Complete the following steps to configure the DNP3 data selection:

1. Using any text editor, create a file that contains a DNP3 data selection in the JSON format.
    - For content structure, see [DNP3 data selection examples](#dnp3-data-selection-examples).
    - For a table of all available parameters, see DNP3 data selection parameters.
1. Save the file. For example, `DataSelection.config.json`.
1. Use any of the configuration tools capable of making HTTP requests to run either a `POST` or `PUT` command to their appropriate endpoint:

**Note:** The following examples use DNP3-1 as the adapter component name. For more information on how to add a component, see [System components configuration](xref:SystemComponentsConfiguration).

`5590` is the default port number. If you selected a different port number, replace it with that value.

`POST` endpoint: `http://localhost:5590/api/v1/configuration/<componentID>/DataSelection/`

Example using `curl`:

**Note:** Run this command from the same directory where the file is located.

```bash 
curl -d "@DataSelection.config.json" -H "Content-Type: application/json" -X POST "http://localhost:5590/api/v1/configuration/DNP3-1/DataSelection"
```

## DNP3 data selection schema

The full schema definition for the DNP3 data source configuration is in the `DNP3_DataSource_schema.json` file located in one of the folders listed below:


Windows: `%ProgramFiles%\OSIsoft\Adapters\DNP3\Schemas`

Linux: `/opt/OSIsoft/Adapters/DNP3/Schemas`

## DNP3 data selection parameters

The following parameters can be used to configure DNP3 data selection: 

| Parameter | Required | Type | Description |
| --------- | -------- | ---- | ----------- |
| Selected | Optional | `boolean` | If true, data for this item will be collected and sent to the configured OMF endpoint(s). Default is `true`. |
| StreamId | Optional | `string` | The custom identifier used to create the streams. If not specified, the DNP3 adapter will generate a default value based on the `DefaultStreamIdPattern` in the [data source configuration](xref:PIAdapterForDNP3DataSourceConfiguration). |
| Name | Optional | `string` | The optional friendly name of the data item collected from the data source. If not configured, the default value will be the Stream ID. |
| OutstationId | Required | `string` | The identifier of the outstation where the DNP point data should be collected from. Must match the `Id` of one of the configured outstations in the [data source configuration](xref:PIAdapterForDNP3DataSourceConfiguration). |
| Group | Required | `number` | The DNP3 object group number for the point. For a list of supported objects, see [DNP3 supported features](xref:PIAdapterForDNP3SupportedFeatures).  |
| Variation | Optional | `number` | The DNP3 object variation to be requested for the point during a static scan. The default is `0`. For a list of supported objects, see [DNP3 supported features](xref:PIAdapterForDNP3SupportedFeatures). |
| Index | Required | `number` | The index of the point on the outstation. 
| StaticScanScheduleId | Optional | `string` | The identifier of a schedule defined in the [Schedules Configuration](xref:SchedulesConfiguration). By default, no static scan will be configured. For more information, see the [principles of operation](xref:PIAdapterForDNP3PrinciplesOfOperation#StaticData) section. |
| DataFilterId | Optional | `string` | The identifier of a data filter defined in the [data filters configuration](xref:DataFiltersConfiguration). By default, no filter will be applied. |

## DNP3 data selection example

The following is an example of valid DNP3 data selection configuration. The first item is an example of a minimally configured selection item for a `Counter Input` point, the second item is an example of how an `Analog Input` point may be configured by [discovery](xref:PIAdapterForDNP3PrinciplesOfOperation#discovery), and the last three items show an example of some custom configurations for different DNP3 points. You will notice that the second item is not selected, discovered items are not selected by default. 

```json
[
    {
        "outstationId": "Outstation1",
        "group": 20,
        "index": 0
    },
    {
        "selected": false,
        "streamId": "Outstation1.AnalogInput.7",
        "name": null,
        "outstationId": "Outstation1",
        "group": 30,
        "variation": 0,
        "index": 7,
        "StaticScanScheduleId": null,
        "dataFilterId": null
    },
    {
        "streamId": "Outstation1.BinaryInput.Variation2.3",
        "name": "MyBinaryInputPoint",
        "outstationId": "Outstation1",
        "group": 1,
        "variation": 2,
        "index": 3,
        "StaticScanScheduleId": "schedule1",
        "dataFilterId": "DuplicateData"
    },
    {
        "name": "MyDoubleBitBinaryInputPoint",
        "outstationId": "Outstation1",
        "group": 3,
        "index": 2,
        "StaticScanScheduleId": "schedule1",
        "dataFilterId": "DuplicateData"
    },
    {
        "name": "MyOctetStringPoint",
        "outstationId": "Outstation1",
        "group": 110,
        "index": 1
    }
]
```