# Deploy Dotnet Todo App

In this task, deploy sample application to Azure.
Sample application is provided on github. Please check the https://github.com/akubicharm/cosmos-dotnet-core-todo-app


## Step1: Deploy CosmosDB


### __For bash__

##### 1. Set Environment Variables

```
export RGNAME=MyWorkshop
export REGION=eastasia
export COSMOS_ACCOUNT=todo$RAND
export COSMOS_DB=Tasks
export COSMOS_CONT=Item
export COSMOS_PARTKEY='/id'
```

##### 2. Generate deployment script
Copy and paste the followings on bash terminal.

```
cat << EOF > forCosmos

az group create --name $RGNAME --location $REGION

# Create CosmosDB Account
az cosmosdb create -g $RGNAME -n $COSMOS_ACCOUNT --locations regionName=$REGION

# Create DB
az cosmosdb sql database create \
    -a $COSMOS_ACCOUNT \
    -g $RGNAME \
    -n $COSMOS_DB \
    --throughput $COSMOS_THROUGHPUT


# Create Container
az cosmosdb sql container create \
    -a $COSMOS_ACCOUNT \
    -g $RGNAME \
    -d $COSMOS_DB \
    -n $COSMOS_CONT \
    -p $COSMOS_PARTKEY \
    --throughput 400


az cosmosdb keys list \
    -n $COSMOS_ACCOUNT \
    -g $RGNAME \
    --type connection-strings
EOF
```

##### 3. Deploy CosmosDB with script

```
chmod 755 forCosmos
./forCosmos
```

---

### __For Powershell__

```
$randVal = get-random
$RGNAME="MyWorkshop"
$REGION="eastasia"
$COSMOS_ACCOUNT="todo$randVal"
$COSMOS_DB="Tasks"
$COSMOS_CONT="Item"
$COSMOS_PARTKEY="/id"

az group create --name $RGNAME --location $REGION

az cosmosdb create -g $RGNAME -n $COSMOS_ACCOUNT --locations regionName=$REGION

az cosmosdb sql database create \
    -a $COSMOS_ACCOUNT \
    -g $RGNAME \
    -n $COSMOS_DB \
    --throughput 400

az cosmosdb sql container create \
    -a $COSMOS_ACCOUNT \
    -g $RGNAME \
    -d $COSMOS_DB \
    -n $COSMOS_CONT \
    -p $COSMOS_PARTKEY \
    --throughput 400
```

## Step 2. Build application

### 1. clone sourcecode from github

```
git clone https://github.com/akubicharm/cosmos-dotnet-core-todo-app
```

### 2. build application  readme.md

Build application according to readme.md

```
dotnet build
```

### 3. get cosmosDB information.


Get CosmosDB URI and Primary Key


##### __for Azure CLI__

>
> As following command shows primaryKey.
> ```
> az cosmosdb keys list -n $COSMOS_ACCOUNT -g $RGNAME  --query primaryMasterKey
> ```
>
> As following command shows cosmosDB URI.
>```
>az cosmosdb show -n $COSMOS_ACCOUNT -g $RGNAME --query documentEndpoint
>```


##### __for Azure Portal__

>
> 1. Access Azure Portal and select resource group.
> 2. Select cosmosDB from resource list.
> 3. Select [keys] in Settings setion on the left pane.
> 4. Check URI and PRIMARY KEY.
>



### 4. Edit application settings file.

Copy appsettings.json.sample to appsettings.json.
Edit appsettings.json files with CosmosDB URI and PRIMARYKEY to enable connecting CosmosDB.
Edit appsettings.json files with Application Insighs Instrumentation Key.

```
{
  "ApplicationInsights": {
    "InstrumentationKey" : "[YOUR APPINSIGHTS INSTRUMENTATION KEY"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*",
  "CosmosDb": {
    "Account": "https://[YOUR COSMOSDB ACCOUNT].documents.azure.com:443/",
    "Key": "[YOUR PRIMAR KEY]",
    "DatabaseName": "Tasks",
    "ContainerName": "Item"
  }
}
```

## Step3. Deploy with Visual Studio Code

If Azure App Service Extention is not installed on your VSCode, please install extentions accouding to [Deploy to Azure App Service using Visual Studio Code](https://docs.microsoft.com/en-us/azure/javascript/tutorial-vscode-azure-app-service-node-01#_install-the-extension)


### 1. Open application folder on VSCode
Open folder using `File >>> Open...` pull-down menu.

### 2. Sign in to your Azure account.

Open command palette using `View >>> Command Palette` pull-down menu.
And choose `Azure > Sign in` menu.


### 3. Deploy application
* Choose Azure icon on left pane.
* Click on the Deploy button on the Azure App Service extension.
* Select the src folder to deploy.

* Select your Azure subscription and whether you want to select an existing Web App or create a new one. Note: If you choose to create a new one, the App Name chosen must be globally unique.

* After a short time, Visual Studio Code will complete the deployment and a visual prompt to Browse Website should appear.

### 4. Enable App Service Logs

* On the Azure Portal, select App Service resource which is created on the last tasks.
* Select [App Service Logs] menu in the Monitoring section.
* Set enabled of logging
 * Application Logging (filesystem)
 * Web server logging (File System)
 * Retention Period(Days)
 * Detailed error messages
 * Failed request tracing
* Clik [Save] button.


### 5. Access application from Browser

Access WebApp URL from Browser, and execute  List, Create.

This application can intensionally throw exception from some API.

##### (a) Throw ArgumentException

When you create a task with title name 'Error', application thorws ArgumentException.

Following the steps.

1. Access WebApp URL
2. Click [Create New]
3. Input 'Error' into Name field and click [Create] button


##### (b) Exception occurred on CosmosDB

Sample application implemented ForceError API. This API attempts to get Item from CosmosDB with id (null).

Following the steps.

1. Access WebApp URL
2. Click [Force Error on CosmosDB]



## References
* https://docs.microsoft.com/en-us/azure/javascript/tutorial-vscode-azure-app-service-node-01#_install-the-extension


[Agenda](./agenda.md) | [Next](./executeApp.md)
