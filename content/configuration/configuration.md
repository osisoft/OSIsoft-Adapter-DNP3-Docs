---
uid: DNP3Configuration
---

# Configuration

PI Adapter for DNP3 provides configuration of data source and data selection.

The examples in the configuration topics use `curl`, a commonly available tool on both Windows and Linux. You can configure the adapter with any programming language or tool that supports making REST calls or with the EdgeCmd utility. For more information, see the [EdgeCmd utility documentation](https://docs.osisoft.com/bundle/edgecmd/page/index.html). To validate successful configurations, you can perform data retrieval (GET commands) with a browser, if available, on your device.

For more information on PI Adapter configuration tools, see [Configuration tools](xref:ConfigurationTools).

## Quick start

This Quick Start guides you through setup of each configuration file available for PI Adapter for DNP3. As you complete each step, perform each required configuration to establish a data flow from a data source to one or more endpoints. Some configurations are optional.

**Important:** If you want to complete the optional configurations, complete those tasks before the required tasks.

1. Configure one or several DNP3 system components.<br>See [System components](xref:SystemComponentsConfiguration#configure-system-components).

2. Configure a DNP3 data source for each DNP3 device.<br>See [Data source](xref:PIAdapterForDNP3DataSourceConfiguration#configure-dnp3-data-source).

3. **Optional**: Configure schedules.<br>See [Schedules](xref:SchedulesConfiguration#configure-schedules).

4. Configure a DNP3 data selection for each DNP3 data source.<br>See [Data selection](xref:PIAdapterForDNP3DataSelectionConfiguration#configure-dnp3-data-selection).

5. **Optional**: Configure data filters, diagnostics and metadata, buffering, and logging<br>See the following topics:

    - [Data filters](xref:DataFiltersConfiguration#configure-data-filters)
    - [Diagnostics and metadata](xref:GeneralConfiguration#configure-general)
    - [Buffering](xref:BufferingConfiguration#configure-buffering)
    - [Logging](xref:LoggingConfiguration#configure-logging)

6. Configure one or several egress and health endpoints.<br>See [Egress endpoints](xref:EgressEndpointsConfiguration) and [Health endpoints](xref:HealthEndpointConfiguration#configure-health-endpoint).
