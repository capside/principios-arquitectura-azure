#!/bin/bash
if [ "X$1" == "X" ]
then
    exit
fi

resource_group="$1rg"
vm_name="vm$1"
username="$1"
region=westeurope
storage_account="$1vmstorage"
vnet_name="$1-vnet"
subnet_name="$1-subnet"

azure provider register --namespace Microsoft.Network
azure provider register --namespace Microsoft.Storage
azure provider register --namespace Microsoft.Compute
    
azure vm quick-create \
  --resource-group $resource_group \
  --name  $vm_name \
  --location $region \
  --os-type Linux \
  --image-urn canonical:UbuntuServer:14.04.3-LTS:latest \
  --vm-size Standard_A0 \
  --admin-username $username \
  --ssh-publickey-file id_rsa.pub  \
  --custom-data customdata.sh
  
azure vm show $resource_group $vm_name
  
  
