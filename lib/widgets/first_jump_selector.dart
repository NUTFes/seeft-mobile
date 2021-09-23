import 'package:seeft_mobile/configs/importer.dart';
import 'package:seeft_mobile/pages/my_shift_page.dart';
// import 'package:seeft_mobile/pages/sign_up_page.dart';
import 'package:seeft_mobile/pages/sign_in_page.dart';

class FirstJumpSelector extends StatefulWidget {
  @override
  _FirstJumpSelectorState createState() => new _FirstJumpSelectorState();
}

class _FirstJumpSelectorState extends State<FirstJumpSelector> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => logger.w('progress duration:'));
  }

  Future<bool> getPrefRead() async {
    final _isUserID = await store.isUserID();
    return _isUserID;
  }

  @override
  Widget build(BuildContext context) {
    logger.i('navigated Splash.');

    return FutureBuilder(
      future: getPrefRead(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        var hasData = snapshot.hasData;
        if (hasData == false) {
          logger.w('can\'t final snapshot data');
          return CircularProgressIndicator();
        }

        var isUserID = snapshot.data;
        var homeWidget;
        /*
        if (isUserID!) {
          logger.i('select MainPage.');
          homeWidget = new MyShiftPage();
        } else {
          logger.i('select SignUpPage.');
          homeWidget = new SignUpPage();
        }
        */
        if (isUserID!) {
          logger.i('select SignInPage.');
          homeWidget = new SignInPage();
        } else {
          logger.i('select MainPage.');
          homeWidget = new MyShiftPage();
        }

        var app = new MaterialApp(
          title: constant.appName,
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
              },
            ),
          ),
          home: homeWidget,
        );

        return app;
      },
    );
  }
}
