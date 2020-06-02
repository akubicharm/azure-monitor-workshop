# Build, Deploy and execute local
Build & Package
jar パッケージでパッケージングをするとWEB-INF/*.jspが含まれないので、パッケージ方法を war にする。

Execute
java -jar *.war

# Deploy to Azure
mvn azure-webapp:deploy


# App Service Config

Settings.Configuration -> General Settings -> Application Settings
JAVA_OPTS = /home/site/wwwroot/applicationinsights-agent-2.5.0.jar

Settings.Configuration -> General Settings -> Startup Command
java -jar /home/site/wwwroot/app.war



# App Insights連携

## ローカル実行
java -javaagent:appinsights/applicationinsights-agent-2.5.0.jar -jar target/app.war

Java WebプロジェクトでAppliation Insightsを使う
https://docs.microsoft.com/ja-jp/azure/azure-monitor/app/java-get-started

キャッチされた例外、メソッド実行時間の監視
https://docs.microsoft.com/ja-jp/azure/azure-monitor/app/java-agent


