import 'package:seeft_mobile/configs/importer.dart';

final ShiftTable table = ShiftTable();

class ShiftTable {
  Widget shiftTable(var shifts) {
    return Table(
        border: TableBorder.all( color: Colors.black),
        columnWidths: const <int, TableColumnWidth>{
          // 0: IntrinsicColumnWidth(),
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(7),
          // 2: FixedColumnWidth(100.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            TableCell(
                child: Container(
              child: Text("日時"),
              alignment: Alignment.center,
              color: Colors.teal,
            )),
            TableCell(
              child: Container(
                child: Text("シフト"),
                alignment: Alignment.center,
                color: Colors.teal,
              ),
            )
          ]),
          for (var shift in shifts)
            TableRow(
                decoration: BoxDecoration(color: Colors.white60),
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
}