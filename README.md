## Intune custom compliance demo

Microsoft has recently released [Intune for Linux](https://learn.microsoft.com/en-us/mem/intune/user-help/enroll-device-linux) with Ubuntu as the first target platform. Intune is a mobile device management (MDM) software that monitors the endpoint compliance status and uses this information to make access decisions for resources protected by Azure Active Directory.

Intune for linux has a predefined set of policies, but also allows the use of custom compliance scripts, to extend its capabilities. You can refer to the [Microsoft documentation](https://learn.microsoft.com/en-us/mem/intune/protect/compliance-use-custom-settings) for additional information on the functionality.


## Description 

The scope of this work is to create a custom compliance script that allows to check

* **Running processes** - this is useful to check that your endpoint protection solution(e.g. [Microsoft Defender](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint-linux?view=o365-worldwide)) is running
* **Ubuntu Pro service status** - [Ubuntu Pro](https://ubuntu.com/pro) is Canonical comprehensive subscription for open source software security. In order to achieve and maintain an appropriate security posture it is important that the following services are enabled:
    * [Esm-apps](https://ubuntu.com/security/esm) extended security support 23,000+ packages in the Ubuntu Universe repository for 10 years
    * [Esm-infra](https://ubuntu.com/security/esm) extended security support for the 2,300 packages in the Ubuntu Main repository for 10 years
    * [Livepatch](https://ubuntu.com/security/livepatch) automatically patches the Linux kernel while the system runs, applying the fixes without the need for a system reboot

The scripts are based on the samples provided by [Microsoft](https://github.com/microsoft/shell-intune-samples/tree/master/macOS) and extended to add support for Ubuntu Pro service status verification. [Ubuntu Pro](https://ubuntu.com/pro) is available for free for personal use for up to 5 machines (or 50 if you are an [Ubuntu community member](https://wiki.ubuntu.com/Membership)) 


## Usage 

The repository includes the following examples:

* complianceScript.sh - which is going to be used by the intune client to perform the checks
* compliancePolicy.json - the policy definition file that tells Intune what to expect from the aforementioned script and how to determine if the device is compliant or not

The scripts are code samples I used to create a technical demo and are by no means intended for production use.

Please refer to the [Microsoft documentation](https://learn.microsoft.com/en-us/mem/intune/protect/compliance-use-custom-settings) for detailed instructions on how to configure the files in the Intune console and deploy/configure Intune on an Ubuntu Desktop


## Disclaimer 

Understand the potential implications of applying the scripts to your target environment before applying them to your target environment. Please consider testing the solution in a non production tenant/endpoint.