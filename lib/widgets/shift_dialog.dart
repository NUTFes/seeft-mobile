import 'package:seeft_mobile/configs/importer.dart';

void openDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text("Title"),
        children: <Widget>[
          // コンテンツ領域
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: Text("１項目目"),
          ),
        ],
      );
    },
  );
}
