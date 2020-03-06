---
uid: OSIsoftAdapterForDNP3Overview
---

# OSIsoft Adapter for DNP3 overview

The OSIsoft Adapter for DNP3 is a data-collection component that transfers time-series data from source devices to OSIsoft OMF endpoints in OSIsoft Cloud Services or PI Servers. [...]

The adapter is installed with a download kit obtained from the OSIsoft Customer Portal and works on devices running either Windows or Linux operating systems.

All functions of the adapter are configured using REST API and configurations are stored in JSON files.
For data ingress, an adapter component must be defined in System components configuration for each device to which the adapter will connect. Each adapter component is then configured with the connection information for the device and the data to collect.
For data egress, configuration is needed to specify destinations for the data, including security for the outgoing connection. Additional configurations are available to egress health and diagnostics data, add buffering configuration to protect against data loss, and record logging information for troubleshooting.

Once the adapter is configured and sending data, use administration functions to manage the adapter or individual ingress components of the adapter. Use health and diagnostics functions to monitor the status of connected devices, adapter system functions, the number of active data streams, the rate of data ingress, the rate of errors, and the rate of data egress.

The EdgeCmd utility is an OSIsoft proprietary command line tool that is used to configure and administer an adapter on both Linux and Windows operating systems. It is installed separately from the adapter.
