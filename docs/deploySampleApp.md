# サンプルアプリケーションをデプロイ

 script ディレクトリにある

 * env_first
 * env
 * deployCosmosdb.sh
 * deployFunc.sh
 * deployWebApp.sh

 を利用して、サンプルアプリケーションをデプロイします。


 #### (1) 環境変数の設定

 env_first の SUFFIX, PREFIX はアプリケーション名などを一意にするために利用するにで、適宜編集してください。

 ```
 . ./env_first
 . ./env
 ```

 #### (2) CosmosDBのデプロイ
 DB名 `ToDoDB`、コンテナ名 `ToDo` という属性で、CosmosDBをデプロイします。

 deployCosmosdb.sh を利用してデプロイ用のスクリプト(forCosmos)を生成します。

 ```
 deployCosmosdb.sh
 ```

 出力された forCosmos ファイルで、パラメータが正しく設定されていることを確認し、デプロイを実行します。

 ```
 forCosmos
 ```

 最後に出力されたキーのうち、Primary Keyをあとで利用するので、どこいかにメモしておいてください。


#### (3) Function のデプロイ
CosmosDBにアクセスするFunction Appをデプロイします。
この作業では、Azure CLI 以外に Function Toolを利用するので、インストールされていない場合はインストールしてください。
![Azure Function Tool](https://docs.microsoft.com/ja-jp/azure/azure-functions/functions-run-local)

Azure Cloud Shell を利用している場合は、インストール済みです。

Function のサンプルアプリケーションをダウンロードします。
https://github.com/akubicharm/func-node-todoapp

deployFunc.sh を利用して、デプロイ用のスクリプト(forFunc)を生成します。

```
deployFunc.sh
```

出力された forFunc2 ファイルを編集します。
出力された forFuncの最後の行の COSMOS DB PRIMARY KEY を、先ほどメモしておいたCosmosDBのプライマリキーに置き換えます。

```
az functionapp config appsettings set --name fappws12651keomizo --resource-group ws12651 --settings "TODO_DOCUMENTDB=[COSMOS DB Primary Key"
```

Functionを作成します。

```
forFunc1
```

Functionのサンプルアプリケーションを展開したディレクトリに移動します。
移動したディレクトリには、以下のディレクトリとファイルがあることを確認します。
```
GetToDo/
ListToDo/
host.json
local.settings.json
package.json
proxies.json
```

Functionアプリケーションをデプロイして、必要な環境変数を設定します。

```
forFunc2
```

#### (4) App Insightsのインスツトルメンテーションキーを確認

Function と同じ名前で生成された、Application Insightsのオーバービュー画面を表示します。
右上の領域に表示された Instrumentation Keyを確認します。

deployWebApp.sh を利用して、Web Appデプロイ用のスクリプト(forWebapp)を生成します。生成されたforWebappスクリプトにApplication InsightsのInstrumentation Keyを記載します。

```
az webapp config appsettings set --name uiws12651keomizo --resource-group ws12651 --settings INSTRUMENTATION_KEY=[App_Insights_Instrumentation_Key]
```


[Agenda](./agenda.md) | [Next](./monitoringException.md)
