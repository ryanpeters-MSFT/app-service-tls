# Azure App Service TLS Sandbox

This repository can be used to test scenarios around TLS configuration. Specifically, this repository targets deployments to an Azure Virtual Machine running Windows 2019 and an App Service. 

The setup is to allow for app deployment and testability of TLS connections (1.2 and 1.3 specifically). In this scenario, a workload running on Windows 2019 would fail due to the OS only supporting TLS 1.2. This is due to the App Service configured to use TLS 1.3. 

## TLS Handshake

TLS handshake: the client sends a ClientHello advertising its highest supported TLS version and cipher suites, the server replies with a ServerHello choosing the highest mutually supported version and a cipher, presents its certificate, and both sides perform an ephemeral key exchange to derive symmetric keys, then exchange Finished messages to confirm integrity; modern implementations automatically negotiate the newest common TLS version.

## Sandbox Resources

This sandbox contains two .NET 8 applications - web and API. The "web" application connects to the "API" to retrieve a greeting at the `/hello` endpoint. 

## Resource Deployment

1. Invoke `.\setup.ps1` to provision an App Service with TLS 1.3 and an Windows 2019 VM
2. Deploy the "web" and "API" apps using your method of choice. 
    - For example, deploy the "web" app to the VM and the "API" to the App Service and test connectivity.
    - As an alternate, deploy the "API" to the VM and connect to it from the "web" app deployed to the App Service.
    - For either scenario, ensure the `ApiUrl` in `appsettings.json` (or global website configuration) is set to the base URL of the API endpoint. 