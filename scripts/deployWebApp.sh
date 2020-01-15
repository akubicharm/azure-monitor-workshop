. ./env

export FUNC_URL="https://$FAPPNAME.azurewebsites.net"
export INSTRUMENTATION_KEY="[App_Insights_Instrumentation_Key]"


cat << EOF > forWebapp

az appservice plan create --resource-group $RGNAME --name $AP_PLAN --location $REGION --sku FREE --is-linux
az webapp create --name $WEBAPPNAME --plan $AP_PLAN --resource-group $RGNAME --runtime "$WEBAPPRUNTIME" --deployment-source-url https://github.com/akubicharm/webapp_todoui_python_with_trace



#az webapp up --dryrun --resource-group $RGNAME --name $WEBAPPNAME
#az webapp update --resource-group $RGNAME --name $WEBAPPNAME


az webapp config appsettings list --name $WEBAPPNAME --resource-group $RGNAME
az webapp config appsettings set --name $WEBAPPNAME --resource-group $RGNAME --settings FUNC_URL=$FUNC_URL
az webapp config appsettings set --name $WEBAPPNAME --resource-group $RGNAME --settings INSTRUMENTATION_KEY=$INSTRUMENTATION_KEY

EOF
