import 'dart:developer';

import 'package:seeft_mobile/configs/importer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:seeft_mobile/pages/my_shift_page_preparation_day_sunny.dart';
import 'package:seeft_mobile/pages/my_shift_page_preparation_day_rainy.dart';
import 'package:seeft_mobile/pages/my_shift_page_current_day_sunny.dart';
import 'package:seeft_mobile/pages/my_shift_page_current_day_rainy.dart';
import 'package:seeft_mobile/pages/my_shift_page_cleanup_day.dart';

class MyShiftPage extends StatefulWidget {
  @override
  _MyShiftPageState createState() => _MyShiftPageState();
}

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class _MyShiftPageState extends State<MyShiftPage>
    with SingleTickerProviderStateMixin {
  final List<TabInfo> _tabs = [
    TabInfo("準備日晴れ", MyShiftPagePreparationDaySunny()),
    TabInfo("準備日雨", MyShiftPagePrepationDayRainy()),
    TabInfo("準備日晴れ", MyShiftPageCurrentDaySunny()),
    TabInfo("準備日雨", MyShiftPageCurrentDayRainy()),
    TabInfo("片付け日", MyShiftPageCleanupDay()),
  ];
  late TabController _tabController;
// notification関連をinitStateに書き出さなきゃいけないので書いてたけどutilとかに書いてもいいかもね

//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//  NotificationDetails platformChannelSpecifics;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイシフト'),
        actions: <Widget>[],
        bottom: PreferredSize(
          child: TabBar(
            isScrollable: true,
            tabs: _tabs.map((TabInfo tab) {
              return Tab(text: tab.label);
            }).toList(),
            controller: _tabController,
          ),
          preferredSize: Size.fromHeight(30.0),
        ),
        // debug
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("マイシフト"),
            leading: const Icon(Icons.dvr),
            onTap: () => {},
          ),
          ListTile(
            title: Text("全体シフト"),
            leading: Icon(Icons.dynamic_feed),
            onTap: () => {},
          ),
          ListTile(
            title: Text("マニュアル一覧"),
            leading: Icon(Icons.list_alt),
            onTap: () => {},
          ),
          ListTile(
            title: Text("タイムスケジュール"),
            leading: Icon(Icons.schedule),
            onTap: () => {},
          ),
          ListTile(
            title: Text("本部連絡先"),
            leading: Icon(Icons.contact_phone),
            onTap: () => {},
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
      body: TabBarView(
          controller: _tabController,
          children: _tabs.map((tab) => tab.widget).toList()),
    );
  }
}
