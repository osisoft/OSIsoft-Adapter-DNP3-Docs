---
uid: DNP3Configuration
---

# Configuration


## Logging
Use the logging configuration to collect information about how the DNP3 adapter and its components are performing. Set the severity level for the messages to capture, anywhere from critical errors only to debugging messages for troubleshooting.

The DNP3 adapter allows you to configure logging on both the system and the component level. 

### Default logging configuration and schema
By default, logging captures Information, Warning, Error, and Critical messages in the message logs. The following logging configuration is the default for a component on install or addition of an adapter component:
```json
{
  "logLevel": "Information",
  "logFileSizeLimitBytes": 34636833,
  "logFileCountLimit": 31
}
```
### Change logging configuration

1. Using any text editor, create a file that contains a logging configuration.
1. Save the file with the .json file extension. For example, Component_Logging.json.
1. Use any tool capable of making HTTP requests to execute a PUT command with the contents of that file to one of the following endpoints:
    * System-level: `http://localhost:<port>/api/v1/configuration/system/logging`
    * Component-level: `http://localhost:<port>/api/v1/configuration/<ComponentId>/logging`
 
 **Note:** Replace <port> with the port the adapter is running and <ComponentId> with the name of the adapter component.
  
Example using curl in the same directory where the file is located.

> curl -i -d "@Component_Logging.json" -H "Content-Type: application/json" -X PUT http://localhost:<port>/api/v1/configuration/<ComponentId>/logging
  
### Log Levels 
The log level sets the minimum severity for messages to be included in the logs. Messages with a severity below the level set are not included. The log levels in their increasing order of severity are as follows: Trace, Debug, Information, Warning, Error, Critical.

| Level | Description |
| ----------- | ----------- |
| Trace | Logs that contain the most detailed messages. These messages may contain sensitive application data. These messages are disabled by default and should never be enabled in a production environment. |
| Debug | Logs that are used for interactive investigation during development. These logs should primarily contain information useful for debugging and have no long-term value. |
| Information | Logs that track the general flow of the application. These logs should have long-term value. |
| Warning | Logs that highlight an abnormal or unexpected event in the adapter flow, but do not otherwise cause the adapter execution to stop. |
| Error | Anything unexpected that the adapter encountered that the user should be aware of, especially if it may mean data loss. |
| Critical | Logs that describe an unrecoverable application or system crash, or a catastrophic failure that requires immediate attention. |

### Parameters for logging 
| Parameter | Required | Type | Nullable | Description |
| --------- | -------- | ---- | -------- | ----------- |
| LogFileCountLimit | Optional | integer | Yes | The maximum number of log files that the service will create for the component. It must be a positive integer. |
| LogFileSizeLimitBytes | Optional | integer | Yes | The maximum size in bytes of log files that the service will create for the component. It must be a positive integer. |
| LogLevel | Optional | reference | No | The desired log level. See table above for more detail on the available log levels. |
