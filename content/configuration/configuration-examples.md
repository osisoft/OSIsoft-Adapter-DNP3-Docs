---
uid: PIAdapterForDNP3ConfigurationExamples
---

# Configuration examples

The following JSON samples provide examples for all configurations available for PI Adapter for DNP3.

## System components configuration with two DNP3 adapter instances

```json
[
    {
        "ComponentId": "DNP3-1",
        "ComponentType": "DNP3"
    },
    {
        "ComponentId": "DNP3-2",
        "ComponentType": "DNP3"
    },
    {
        "ComponentId": "OmfEgress",
        "ComponentType": "OmfEgress"
    }
]
```

## Adapter configuration

```json
{
  "DNP3-1": {
    "Logging": {
      "logLevel": "Information",
      "logFileSizeLimitBytes": 34636833,
      "logFileCountLimit": 31
    },
    "DataSource": {
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
          "EventClasses": [1, 2, 3],
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
          "EventClasses": [1],
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
    },
    "DataSelection": [
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
  },
  "System": {
    "Logging": {
      "logLevel": "Information",
      "logFileSizeLimitBytes": 34636833,
      "logFileCountLimit": 31
    },
    "HealthEndpoints": [],
    "Diagnostics": {
      "enableDiagnostics": true
    },
    "Components": [
      {
        "componentId": "Egress",
        "componentType": "OmfEgress"
      },
      {
        "componentId": "DNP3-1",
        "componentType": "DNP3"
      }
    ],
    "Buffering": {
      "BufferLocation": "C:/ProgramData/OSIsoft/Adapters/DNP3/Buffers",
      "MaxBufferSizeMB": -1,
      "EnableBuffering": true
    }
  },
  "OmfEgress": {
    "Logging": {
      "logLevel": "Information",
      "logFileSizeLimitBytes": 34636833,
      "logFileCountLimit": 31
    },
    "DataEndpoints": [
      {
        "id": "WebAPI EndPoint",
        "endpoint": "https://PIWEBAPIServer/piwebapi/omf",
        "userName": "USERNAME",
        "password": "PASSWORD"
      },
      {
        "id": "OCS Endpoint",
        "endpoint": "https://OCSEndpoint/omf",
        "clientId": "CLIENTID",
        "clientSecret": "CLIENTSECRET"
      },
      {
        "Id": "EDS",
        "Endpoint": "http://localhost:/api/v1/tenants/default/namespaces/default/omf",
        "UserName": "eds",
        "Password": "eds"
      }
    ]
  }
}
```

## Data source configuration

Use one of the following data source configurations examples for the DNP3 adapter as a template for your own configuration.

### Minimum configuration for a single outstation

The following example is a configuration for a single outstation on a single TCP channel.

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

### Configuration for multiple outstations

The following example is a configuration for two outstations that are on one channel and one outstation that is on a separate channel. Rather than using the default configurations, many configuration options are expressed here.

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
      "EventClasses": [1, 2, 3],
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
      "EventClasses": [1],
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

## Data selection configuration

The following is an example of a valid DNP3 data selection configuration.

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
