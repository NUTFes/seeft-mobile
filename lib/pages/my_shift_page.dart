import 'package:seeft_mobile/configs/importer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyShiftPage extends StatefulWidget {
  @override
  _MyShiftPageState createState() => _MyShiftPageState();
}

class _MyShiftPageState extends State<MyShiftPage> {
// notification関連をinitStateに書き出さなきゃいけないので書いてたけどutilとかに書いてもいいかもね

//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//  NotificationDetails platformChannelSpecifics;

  @override
  void initState() {
    super.initState();
/*
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocationLocation);
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
*/
  }

  Future onSelectNotification(String payload) async {
/*
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CouponListDetail(id: payload),
        maintainState: false,
      ),
    );
*/
  }

  /// iOS用のイベント
  Future onDidReceiveLocationLocation(
      int id, String title, String body, String payload) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(payload),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text('ホーム'),
          ),
          // debug
          actions: <Widget>[
            //Widget
          ]),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: <Widget>[
            Container(
              height: size.height - 200,
              width: size.width - 80,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: _contents(size),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contents(Size size) {
    return Column(children: <Widget>[
      SizedBox(
        width: size.width - 100,
        child: Text(
          "新着情報",
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(
        width: size.width - 100,
        child: Text(
          '- 11/12',
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(
        width: size.width - 100,
        child: Text(
          '- 11/13',
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(
        child: RaisedButton(
          onPressed: () async {
            final result = api.getMyShift;
            _onNotification(result);
          },
          child: Text('GET'),
        ),
      ),
    ]);
  }

  Future _onNotification(result) async {
    List list = await result;
    list.asMap().forEach((int index, element) async {
      if (element["COUPON_ID"] != '0') {
        try {
          Map<String, dynamic> row = {'coupon': element["COUPON_ID"]};
/*          await flutterLocalNotificationsPlugin.show(
            index,
            'STREAM_ID' + element["STREAM_ID"],
            element["URL"],
            platformChannelSpecifics,
            payload: element["COUPON_ID"],
          );
*/
        } catch (e) {
          logger.e(e);
        }
      }
    });
  }
}
