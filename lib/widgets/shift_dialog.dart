import 'package:logger/logger.dart';
import 'package:seeft_mobile/configs/importer.dart';
import 'package:url_launcher/url_launcher.dart';

getShiftDetail(workId, userId, date, weather, time) async {
  try {
    logger.w(workId);
    var res = await api.shiftDetail(workId, userId, date, weather, time);
    return res;
  } catch (e) {}
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Unable to launch url $url';
  }
}

openShiftDialog(
    BuildContext context, workId, userId, date, weather, time) async {
  var res = await getShiftDetail(workId, userId, date, weather, time);
  logger.i(res);
  var resName = res["Name"];
  //var resURL = res["URL"];
  var resUsers = res["Users"];
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: Container(
          height: 550,
          child: Scaffold(
            appBar: AppBar(
              title: Text(resName), //シフト名
              centerTitle: true,
            ),
            body: Container(
              child: Text(resUsers),
            ),
            floatingActionButton: OutlinedButton(
              child: const Text('マニュアルへ'),
              style: OutlinedButton.styleFrom(
                primary: Colors.orangeAccent,
                side: const BorderSide(color: Colors.orangeAccent),
              ),
              onPressed: () async {
                //_launchURL(resURL);
              },
            ),
          ),
        ),
      );
    },
  );
}
