#!/bin/bash -v

. ./env


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

