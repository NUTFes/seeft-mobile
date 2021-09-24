import 'package:seeft_mobile/configs/importer.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text('ホーム'),
          ),
          backgroundColor: Colors.teal[400],
          // debug
          actions: <Widget>[
            //Widget
          ]),
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
                        child: _table(snapshot.data, context)),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

Widget _table(var shifts, context) {
  return Table(
      border: TableBorder.all(color: Colors.white),
      columnWidths: const <int, TableColumnWidth>{
        // 0: IntrinsicColumnWidth(),
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(10),
        // 2: FixedColumnWidth(100.0),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(decoration: BoxDecoration(color: Colors.green[50]), children: [
          TableCell(
              child: Container(
            child: Text("日時"),
            alignment: Alignment.center,
          )),
          TableCell(
            child: Container(
              child: Text("場所"),
              alignment: Alignment.center,
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
                  width: double.infinity,
                  height: 54.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      child: new Text(shift["Work"].toString()),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.teal,
                      ),
                      onPressed: () async {
                        openDialog(context);
                      }),
                  /*
                  alignment: Alignment.center,
                  child: new Text(shift["Work"].toString()),
                  // margin: EdgeInsets.only(bottom: 10.0),
                  height: 25,
                  */
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
