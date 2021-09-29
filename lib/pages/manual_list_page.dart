import 'dart:developer';

import 'package:seeft_mobile/configs/importer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ManualListPage extends StatefulWidget {
  @override
  _ManualListPageState createState() => _ManualListPageState();
}

class _ManualListPageState extends State<ManualListPage> {
// notification関連をinitStateに書き出さなきゃいけないので書いてたけどutilとかに書いてもいいかもね

//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//  NotificationDetails platformChannelSpecifics;
  int manualLength = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('マニュアル一覧'),
        actions: <Widget>[],
        // debug
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("マイシフト"),
            leading: const Icon(Icons.dvr),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/my_shift_page', (Route<dynamic> route) => false)
            },
          ),
          ListTile(
            title: Text("全体シフト"),
            leading: Icon(Icons.dynamic_feed),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/all_shift_page', (Route<dynamic> route) => false)
            },
          ),
          ListTile(
            title: Text("マニュアル一覧"),
            leading: Icon(Icons.list_alt),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/manual_list_page', (Route<dynamic> route) => false)
            },
          ),
          ListTile(
            title: Text("タイムスケジュール"),
            leading: Icon(Icons.schedule),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/schedule_page', (Route<dynamic> route) => false)
            },
          ),
          ListTile(
            title: Text("本部連絡先"),
            leading: Icon(Icons.contact_phone),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/contact_page', (Route<dynamic> route) => false)
            },
          ),
          ListTile(
            title: Text("再ログイン"),
            leading: Icon(Icons.login),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (Route<dynamic> route) => false)
            },
          ),
        ],
      )),
      body: FutureBuilder(
        future: getData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == AsyncSnapshot.waiting()) {
            logger.w("message");
          }
          if (!snapshot.hasData) {
            const Center(child: CircularProgressIndicator());
          }
          var manualList = snapshot.data;
          return Container(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                Flexible(
                  child: ListView.builder(
                    itemCount: manualLength,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 40,
                          child: _manualItem(snapshot.data, index, context));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _manualItem(var manuals, index, context) {
    return Container(
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        title: Text(
          manuals[index]["Name"].toString(),
          style: TextStyle(color: Colors.black, fontSize: 14.0),
        ),
        onTap: () async {
          if (await canLaunch(manuals[index]["URL"].toString())) {
            await launch((manuals[index]["URL"].toString()));
          }
        },
      ),
    );
  }
  Future getData() async {
    try {
      var res = await api.getAllManual();
      manualLength = res.length;
      return res;
    } catch (err) {
      logger.e('don`t response. error message: $err');
    }
  }
}
