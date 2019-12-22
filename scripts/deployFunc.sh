#!/bin/bash -v

. ./env


cat << EOF > forFunc

az storage account create --name $STORAGE --location $REGION --resource-group $RGNAME --sku Standard_LRS


az functionapp create --resource-group $RGNAME --consumption-plan-location $REGION \
--name $FAPPNAME --storage-account  $STORAGE --runtime $FUNCRUNTIME --os-type Linux


echo "change dir to Func App dir"
echo "func azure functionapp publish $FAPPNAME"
echo "az cosmosdb keys list  -n $COSMOS_ACCOUNT  -g $RGNAME  --type connection-strings"
az functionapp config appsettings set --name $FAPPNAME --resource-group $RGNAME --settings "TODO_DOCUMENTDB=[COSMOS DB Primary Key"

EOF
