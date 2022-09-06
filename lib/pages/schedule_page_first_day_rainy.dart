import 'dart:developer';

import 'package:seeft_mobile/configs/importer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class SchedulePageFirstDayRainy extends StatefulWidget {
  @override
  _SchedulePageFirstDayRainyState createState() =>
      _SchedulePageFirstDayRainyState();
}

class _SchedulePageFirstDayRainyState extends State<SchedulePageFirstDayRainy> {
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
    return Container(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: const<int, TableColumnWidth>{
                    0: FlexColumnWidth(5),
                    1: FlexColumnWidth(10),
                    2: FlexColumnWidth(10),
                    3: FlexColumnWidth(10),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: Container(
                            child: Text("日時"),
                            alignment: Alignment.center,
                            color: Colors.lightGreen,
                          )
                      ),
                      TableCell(
                        child: Container(
                          child: Text("体育館"),
                          alignment: Alignment.center,
                          color: Colors.lightGreen,
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text("A講義室"),
                          alignment: Alignment.center,
                          color: Colors.lightGreen,
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text("D講義室"),
                          alignment: Alignment.center,
                          color: Colors.lightGreen,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
