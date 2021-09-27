import 'package:flutter/material.dart';
import 'package:seeft_mobile/configs/importer.dart';
import 'package:seeft_mobile/pages/contact_page.dart';

/*
var workId = 34;
var userId = 108;
var date = "preparationDay";
var weather = "sunny";
var time = "14:00";
var res = api.shiftDetail(workId, userId, date, weather, time)['ID'];
*/

_getShiftDetail() async {
  var workId = 34;
  var userId = 108;
  var date = "preparationDay";
  var weather = "sunny";
  var time = "14:00";

  try {
    var res = await api.shiftDetail(workId, userId, date, weather, time);
    String resName = res['Name'].toString();

    return resName;
  } catch (e) {}
}

final ShiftDialog dialog = ShiftDialog();

class ShiftDialog {
  Widget shiftDialog
}


/*
void openShiftDialog(BuildContext context) async {
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
              title: Text('Shift Title'),
              centerTitle: true,
            ),
            body: Container(
              child: Text(_getShiftDetail()),
            ),
            floatingActionButton: OutlinedButton(
              child: const Text('マニュアルへ'),
              style: OutlinedButton.styleFrom(
                primary: Colors.orangeAccent,
                side: const BorderSide(color: Colors.orangeAccent),
              ),
              onPressed: () {},
            ),
          ),
        ),
      );
    },
  );
}
*/