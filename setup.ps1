$group = "rg-appservice-tls"
$location = "eastus2"
$appName = "appservicetlsweb"
$vmName = "appservicetlsvm"
$vmNsg = "vmnsg"

# create resource group
az group create --name $group --location $location

# create app service plan
az appservice plan create --name $appName --resource-group $group --sku B1 --is-linux

# create web app
az webapp create --name $appName --resource-group $group --plan $appName --runtime "DOTNETCORE:8.0"

# config TLS 1.3
az webapp config set --name $appName --resource-group $group --min-tls-version "1.3"

# create public IP for the VM
$vmIp = az network public-ip create `
    --resource-group $group `
    --name "pip-$vmName" `
    --sku Standard `
    --allocation-method Static `
    --location $location `
    -o tsv --query publicIp.ipAddress

# create the windows 2019 VM
az vm create `
    --resource-group $group `
    --name $vmName `
    --image "MicrosoftWindowsServer:WindowsServer:2019-Datacenter:latest" `
    --size "Standard_D2s_v3" `
    --admin-username vmuser `
    --nsg $vmNsg `
    --nsg-rule RDP `
    --public-ip-address "pip-$vmName" `
    --location $location

# install IIS on the VM
az vm run-command invoke `
    --resource-group $group `
    --name $vmName `
    --command-id RunPowerShellScript `
    --scripts "Install-WindowsFeature -name Web-Server -IncludeManagementTools"

"VM Public IP: $vmIp"