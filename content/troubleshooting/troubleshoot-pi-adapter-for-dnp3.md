---
uid: TroubleshootPIAdapterForDNP3
---

# Troubleshoot PI Adapter for DNP3

PI Adapter for DNP3 provides troubleshooting features that enable you to verify adapter configuration, confirm connectivity, and view message logs. If you are unable to resolve issues with the adapter or need additional guidance, contact OSIsoft Technical Support through the [OSIsoft Customer Portal](https://my.osisoft.com/).

## Check configurations

Incorrect configurations can interrupt data flow and cause errors in values and ranges. Perform the following steps to confirm correct configuration for your adapter.

1. Navigate to [data source configuration](xref:PIAdapterForDNP3DataSourceConfiguration) and verify the following for each configured data source item below:

      **MasterStationBehaviors**
      * **MasterAddress** - The DNP address on the TCP Channel that the adapter is communicating on is unique. The adapter identifies itself using this address. If there is a conflict, the adapter may have trouble sending/receiving DNP messages to outstations. 
      * **DataLinkLayerTimeout** - The timeout is appropriate for your network. If too small, communications may timeout before completing. If the value is too large, it will take longer to notice communication failures. The default is sufficient in most cases. 
      
      **OutstationBehaviors**
      * **ApplicationLayerTimeout** - The timeout is appropriate for your network. If too small, communications may timeout before completing. If the value is too large, it will take longer to notice communication failures. The default is sufficient in most cases. 
      * **EnableUnsolicited** - The outstations support unsolicited data. If outstations support unsolicited data, there may be no need to configure static or event scans. If your outstations do not support unsolicited data, then the value of this parameter is largely inconsequential. 
      * **EnableTimeSync** - The adapter machine has an accurate time sync. When enabled, the adapter provides the current time to an outstation when requested. If you do not want the outstations to sync with the adapter machine time, mark this as false. 
      * **IntegrityScanOnStartup** - The outstation can handle the burden of an integrity scan on startup. This scan places additional load on the outstation whenever the adapter or outstation is restarted. 
      * **IntegrityScanOnEventBufferOverflow** - The outstation can handle the burden of an integrity scan when the outstation's event buffer overflows. This scan places additional load on the outstation whenever outstation's event buffer overflows. 
      * **IntegrityScanPeriod** - The outstation can handle the burden of an integrity scan at this interval. This scan places additional load on the outstation whenever this interval passes. 
      * **EventClasses** - The points you want to collect event data for are in one of the event classes listed here. If your point is not in any event class, you may need to configure a static scan. 
      * **EventScanPeriod** - The interval is appropriate for your data collection needs. A too short interval may put unnecessary load on the network, adapter, and outstations. A too long interval may allow the outstation's event buffer to overflow. 

      **TCPChannel**
      * **HostNameOrIpAddress** - The hostname is resolvable from the adapter machine, the IP address is reachable, or both. Also, the outstation is listening at this hostname/address. Otherwise, the adapter cannot connect to the outstation. 
      * **Port** - The firewalls between the adapter and outstation allow connections on this port. Also, the outstation is listening on this port. Otherwise, the adapter cannot connect to the outstation. 
      * **MasterStationBehaviorId** - This parameter matches the **Id** of one of the configurations in the **MasterStationBehaviors** list. 
      
      **Outstations** 
      * **DNPAddress** - This parameter matches the DNP Address of your outstation. This is used as an identifier on the DNP network. The adapter only accepts data from an outstation at an address specified here in the configuration. 
      * **OutstationBehaviorId** - This parameter matches the **Id** of one of the configurations in the **OutstationBehaviors** list. 

2. Navigate to [data selection configuration](xref:PIAdapterForDNP3DataSelectionConfiguration) and verify the following for each configured data selection item below:

      * **OutstationId** - This parameter matches the **Id** of one of the **Outstation** configurations. 
      * **Group** - This parameter matches the DNP3 object group number of the point that you want to collect data from. 
      * **Variation** - This variation is supported by your outstation. Behavior is outstation dependent if you specify a variation that is not supported. 
      * **Index** - This parameter matches the point index of the DNP3 point that you want to collect data from. 
      * **StaticScanScheduleId** - This parameter matches the **Id** of a schedule in the **Schedules** configuration. This is the interval at which a static scan is requested, but it is not required if no static scan is desired. 
      * **DataFilterId** - If configured, the referenced data filter exists.<br> A non-existent or incorrect DataFilterId  means that data filtering is not active.

3. Navigate to [egress endpoints configuration](xref:EgressEndpointsConfiguration). For each configured endpoint, verify that the **Endpoint** and authentication properties are correct.

    * For a PI server or EDS endpoint, verify **UserName** and **Password**.
    * For an OCS endpoint, verify **ClientId** and **ClientSecret**.

## Check connectivity

Perform the following steps to verify active connections to the data source and egress endpoints.

1. Start PI Web API and verify that the PI point values are updating or start OCS and verify that the stream values are updating.
2. If configured, use a health endpoint to determine the status of the adapter.<br>For more information, see [Health and diagnostics](xref:HealthAndDiagnostics).

## Check logs

Perform the following steps to view the adapter and endpoint logs to isolate issues for resolution.

1. Navigate to the logs directory:<br>
    Windows: `%ProgramData%\OSIsoft\Adapters\DNP3\Logs`<br>
    Linux: `/usr/share/OSIsoft/Adapters/DNP3/Logs`.
2. Optional: Change the log level of the adapter to receive more information and context.<br>For more information, see [Logging configuration](xref:LoggingConfiguration).
