---
uid: PIAdapterForDNP3DataSelectionConfiguration
---

# Data selection

In addition to the data source configuration, you need to provide a data selection configuration to specify the data you want the DNP3 adapter to collect from your outstations.

Depending on your data source configuration, your data selection configuration can be pre-populated by discovery. For more information, see [PI Adapter for DNP3 data source configuration](xref:PIAdapterForDNP3DataSourceConfiguration) and [Discovery](xref:PIAdapterForDNP3PrinciplesOfOperation#discovery).

## Configure DNP3 data selection

Complete the following steps to configure a DNP3 data selection. Use the `PUT` method in conjunction with the `api/v1/configuration/<ComponentId>/DataSelection` REST endpoint to initialize the configuration.

1. Using a text editor, create an empty text file.

2. Copy and paste an example configuration for a DNP3 data selection into the file.

    For sample JSON, see [DNP3 data selection examples](#dnp3-data-selection-example).

3. Update the example JSON parameters for your environment.

    For a table of all available parameters, see [DNP3 data selection parameters](#dnp3-data-selection-parameters).

4. Save the file. For example, as `ConfigureDataSelection.json`.

5. Open a command line session. Change directory to the location of `ConfigureDataSelection.json`.

6. Enter the following cURL command (which uses the `PUT` method) to initialize the data selection configuration.

    ```bash
    curl -d "@ConfigureDataSelection.json" -H "Content-Type: application/json" -X PUT "http://localhost:5590/api/v1/configuration/DNP3-1/DataSelection"
    ```

    **Notes:**
  
    * If you installed the adapter to listen on a non-default port, update `5590` to the port number in use.
    * If you use a component ID other than `DNP3-1`, update the endpoint with your chosen component ID and stream ID.
    * For a list of other REST operations you can perform, like updating or deleting a data selection configuration, see [REST URLs](#rest-urls).
    <br/>
    <br/>

## DNP3 data selection schema

The full schema definition for the DNP3 data source configuration is in the `DNP3_DataSource_schema.json` file located in one of the following folders:

Windows: `%ProgramFiles%\OSIsoft\Adapters\DNP3\Schemas`

Linux: `/opt/OSIsoft/Adapters/DNP3/Schemas`

## DNP3 data selection parameters

The following parameters are available to configure DNP3 data selection:

| Parameter | Required | Type | Description |
| --------- | -------- | ---- | ----------- |
| **Selected** | Optional | `boolean` | If true, data for this item is collected and sent to one or more configured OMF endpoint.<br><br>Allowed value: `true` or `false`<br>Default value:`true` |
| **StreamId** | Optional | `string` | The custom identifier used to create the streams. If not specified, the DNP3 adapter generates a default value based on the `DefaultStreamIdPattern` in the [PI Adapter for DNP3 data source configuration](xref:PIAdapterForDNP3DataSourceConfiguration). |
| **Name** | Optional | `string` | The optional friendly name of the data item collected from the data source. If not configured, the default value is the stream ID. |
| **OutstationId** | Required | `string` | The identifier of the outstation where the DNP point data should be collected from. Must match the `Id` of one of the configured outstations in the [PI Adapter for DNP3 data source configuration](xref:PIAdapterForDNP3DataSourceConfiguration). |
| **Group** | Required | `number` | The DNP3 object group number for the point. For a list of supported objects, see [PI Adapter for DNP3 supported features](xref:PIAdapterForDNP3SupportedFeatures).  |
| **Variation** | Optional | `number` | The DNP3 object variation to be requested for the point during a static scan. For a list of supported objects, see [PI Adapter for DNP3 supported features](xref:PIAdapterForDNP3SupportedFeatures).<br><br>Default value: `0` |
| **Index** | Required | `number` | The index of the point on the outstation.
| **StaticScanScheduleId** | Optional | `string` | The identifier of a schedule defined in the [Schedules configuration](xref:SchedulesConfiguration). By default, no static scan is configured. For more information, see [Static data](xref:PIAdapterForDNP3PrinciplesOfOperation#static-data). |
| **DataFilterId** | Optional | `string` | The identifier of a data filter defined in the [Data filters configuration](xref:DataFiltersConfiguration). By default, no filter is applied.<br>**Note:** If the specified **DataFilterId** does not exist, unfiltered data is sent until that **DataFilterId** is created. |

## DNP3 data selection example

The following is an example of a valid DNP3 data selection configuration. The first item is an example of a minimally configured selection item for a `Counter Input` point, the second item is an example of how an `Analog Input` point can be configured by [Discovery](xref:PIAdapterForDNP3PrinciplesOfOperation#discovery), and the last three items show an example of some custom configurations for different DNP3 points. Notice that the second item is not selected; discovered items are not selected by default.

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

## REST URLs

| Relative URL | HTTP verb | Action |
| ------------ | --------- | ------ |
| api/v1/configuration/\<ComponentId\>/DataSelection  | `GET` | Retrieves the data selection configuration, including all data selection items. |
| api/v1/configuration/\<ComponentId\>/DataSelection  | `PUT` | Configures or updates the data selection configuration. The adapter starts collecting data for each data selection item when the following conditions are met:<br/><br/>&bull; The data selection configuration `PUT` request is received.<br/>&bull; A data source configuration is active. |
| api/v1/configuration/\<ComponentId\>/DataSelection | `DELETE` | Deletes the active data selection configuration. The adapter stops collecting data. |
| api/v1/configuration/\<ComponentId\>/DataSelection | `PATCH` | Allows partial updating of configured data selection items. <br/><br/>**Note:** The request must be an array containing one or more data selection items. Each item in the array must include its **StreamId**. |
| api/v1/configuration/\<ComponentId\>/DataSelection/\<StreamId\> | `PUT` | Updates or creates a new data selection item by **StreamId**. For new items, the adapter starts collecting data after the request is received. |
| api/v1/configuration/\<ComponentId\>/DataSelection/\<StreamId\> | `DELETE` | Deletes a data selection item from the configuration by **StreamId**. The adapter stops collecting data for the deleted item. |

**Note:** Replace \<ComponentId\> with the Id of your DNP3 component. For example, DNP3-1.
