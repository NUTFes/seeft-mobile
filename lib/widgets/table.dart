import 'package:seeft_mobile/configs/importer.dart';

final ShiftTable table = ShiftTable();

class ShiftTable {
  Widget shiftTable(var shifts, context) {
    return Table(
        border: TableBorder.all(color: Colors.black26),
        columnWidths: const <int, TableColumnWidth>{
          // 0: IntrinsicColumnWidth(),
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(3),
          // 2: FixedColumnWidth(100.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            TableCell(
                child: Container(
              child: Text(
                "日時",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              alignment: Alignment.center,
              color: Colors.orangeAccent,
            )),
            TableCell(
              child: Container(
                child: Text(
                  "シフト",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                alignment: Alignment.center,
                color: Colors.orangeAccent,
              ),
            )
          ]),
          for (var index = 0; index < shifts.length; index++)
            TableRow(
                decoration: BoxDecoration(color: Colors.white60),
                children: [
                  TableCell(
                      child: Container(
                    alignment: Alignment.center,
                    child: new Text(shifts[index]["Time"].toString()),
                  )),
                  TableCell(
                      /*
                      child: Container(
                    alignment: Alignment.center,
                    child: new Text(shift["Work"].toString()),
                    // margin: EdgeInsets.only(bottom: 10.0),
                    height: 25,
                    */
                      child: Container(
                    //color: HexColor(shifts[index]["Color"].toString()),
                    width: double.infinity,
                    height: 40,
                    //color: HexColor(shifts[index]["Color"].toString()),
                    padding: EdgeInsets.all(0),
                    //height: 25.0,
                    child: new Material(
                      type: MaterialType.button,
                      color: HexColor(shifts[index]["Color"]),
                      child: InkWell(
                        splashColor: Colors.orangeAccent,
                        onTap: () async {
                          if (shifts[index]["Work"] != "") {
                            logger.i(shifts[index]["Work"]);
                            await openShiftDialog(
                                context,
                                shifts[index]["WorkID"],
                                shifts[index]["UserID"],
                                shifts[index]["Date"],
                                shifts[index]["Weather"],
                                shifts[index]["Time"]);
                          }
                        },
                        //child: Center(child: new Text(shifts[index]["Work"].toString())),
                        child: Container(
                          child: Center(
                              child:
                                  new Text(shifts[index]["Work"].toString())),
                        ),
                      ),
                    ),
                  ))
                ]),
        ]);
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
