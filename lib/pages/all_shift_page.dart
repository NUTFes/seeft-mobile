import 'dart:developer';

import 'package:seeft_mobile/configs/importer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class AllShiftPage extends StatefulWidget {
  @override
  _AllShiftPageState createState() => _AllShiftPageState();
}

class _AllShiftPageState extends State<AllShiftPage> {
// notification関連をinitStateに書き出さなきゃいけないので書いてたけどutilとかに書いてもいいかもね

//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//  NotificationDetails platformChannelSpecifics;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('全体シフト'),
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
            return CircularProgressIndicator();
          }
          return Container(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                        // height: size.height - 200,
                        // width: size.width - 80,
                        // padding: const EdgeInsets.all(10.0),
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.black),
                        // ),
                        // child: _contents(size, snapshot.data)),
                        child: _table(snapshot.data)),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

Widget _table(var shifts) {
  return Table(
      border: TableBorder.all(color: Colors.black),
      columnWidths: const <int, TableColumnWidth>{
        // 0: IntrinsicColumnWidth(),
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(10),
        // 2: FixedColumnWidth(100.0),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: [
          TableCell(
              child: Container(
            child: Text("日時"),
            alignment: Alignment.center,
            color: Colors.lightGreen,
          )),
          TableCell(
            child: Container(
              child: Text("場所"),
              alignment: Alignment.center,
              color: Colors.lightGreen,
            ),
          )
        ]),
        for (var shift in shifts)
          TableRow(
              decoration: BoxDecoration(color: Colors.grey[200]),
              children: [
                TableCell(
                    child: Container(
                  alignment: Alignment.center,
                  child: new Text(shift["Time"].toString()),
                )),
                TableCell(
                    child: Container(
                  alignment: Alignment.center,
                  child: new Text(shift["Work"].toString()),
                  // margin: EdgeInsets.only(bottom: 10.0),
                  height: 25,
                ))
              ]),
      ]);
}

Future getData() async {
  try {
    var userID = await store.getUserID();
    var res = await api.getMyShift(userID.toString());
    return res;
  } catch (err) {
    logger.e('don`t response. error message: $err');
  }
}
