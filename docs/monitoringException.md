# アプリケーションのエラーを見つける

Application Insightsを利用して、アプリケーションの例外の発生回数や時間、また、その内容を確認します。

※Linuxベースの環境では、Python、Node.jsの場合には AppInsightsにテレメトリを送信するための実装が必要になります。JavaはApplication Insightsw有効にするだけでメトリクスなどが収集可能です。



#### (1) Application Insight 画面の表示

Azureポータル画面にログインし、左Paneのメニューから[Monitor]を選択します。

Azure Monitor画面の左PaneのInsightsセクションの[Application]を選択します。

Application Insights一覧から、対象のApplication Insightsを選択します。

#### (2) 失敗の表示
Application Insightsの画面の右Paneで[Failure]を選択する。または、Overviewの画面で[Failed requests]のグラフをクリックします。
![Failureの表示](images/failed-requests.png)

#### (3) 表示するタイムレンジの変更
タイムウィンドウをドラッグすることで、表示するタイムレンジを変更します。
![Failureの表示](images/failed-requests-window.png)

#### (4) 例外の一覧表示
真ん中のPaneのPaneの"OPERATION NAME"の一覧で、確認したい操作を選択します。次に、右Pane下部のDrill into... の下のボタンをクリックして、エラーの一覧を表示します。
エラー一覧から、エラーをクリックすると JavaのExceptionなどの詳細を参照できます。
![Failureの表示](images/failed-requests-search.png)


[Agenda](./agenda.md) | [Next](./monitoringPerformance.md)
