. ./env


cat << EOF > forFunc1

az storage account create --name $STORAGE --location $REGION --resource-group $RGNAME --sku Standard_LRS


az functionapp create --resource-group $RGNAME --consumption-plan-location $REGION \
--name $FAPPNAME --storage-account  $STORAGE --runtime $FUNCRUNTIME --os-type Linux

EOF

cat << EOF > forFunc2
func azure functionapp publish $FAPPNAME
az cosmosdb keys list  -n $COSMOS_ACCOUNT  -g $RGNAME  --type connection-strings"
az functionapp config appsettings set --name $FAPPNAME --resource-group $RGNAME --settings "TODO_DOCUMENTDB=[COSMOS DB Primary Key]"

EOF


chmod 755 forFunc1 forFunc2
