---
uid: SystemRequirements
---

# System requirements

PI Adapter for DNP3 is supported on a variety of platforms and processors. Install kits are available for the following platforms:

| Operating System | Installation Kit | Processor(s) |
|-------------------|----------------------------------|-------------|
| Windows 10 x64 (any version)  | `DNP3_win10-x64.msi`     | Intel/AMD 64-bit processors |
| Debian 9 or later x64 | `DNP3_linux-x64.deb`     | Intel/AMD 64-bit processors |
| Debian 9 or later arm32 | `DNP3_linux-arm.deb`  | Arm 32-bit processors |
| Debian 9 or later arm64 | `DNP3_linux-arm64.deb`  | Arm 64-bit processors |

__Note:__ For Windows 10 installations, the latest Microsoft Visual C++ Redistributable for Visual Studio 2015, 2017 and 2019 is required. To install, please visit [Microsoft's Website](https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads).

Alternatively, you can use tar.gz files with binaries to build your own custom installers or containers for Linux. For more information on installation of the PI Adapter for DNP3 with a Docker container, see [Install PI Adapter for DNP3 using Docker](xref:InstallPIAdapterForDNP3UsingDocker).
