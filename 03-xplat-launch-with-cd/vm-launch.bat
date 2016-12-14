@echo off
if [%1]==[] exit

SET resource_group=%1-rg
SET vm_name=vm%1
SET username=%1
SET region=westeurope
SET storage_account=%1vmstorage
SET vnet_name=%1-vnet
SET subnet_name=%1-subnet

call azure provider register --namespace Microsoft.Network
call azure provider register --namespace Microsoft.Storage
call azure provider register --namespace Microsoft.Compute
    
call azure vm quick-create ^
  --resource-group %resource_group% ^
  --name  %vm_name% ^
  --location %region% ^
  --os-type Linux ^
  --image-urn canonical:UbuntuServer:14.04.3-LTS:latest ^
  --vm-size Standard_A0 ^
  --admin-username %username% ^
  --ssh-publickey-file id_rsa.pub  ^
  --custom-data customdata.sh
  
call azure vm show %resource_group% %vm_name%    
  
  