import 'package:seeft_mobile/configs/importer.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

/// 利用者登録のページ
class _SignInPageState extends State<SignInPage> {
  String mail = '';
  String infoText = '';

  signIn() async {
    try {
      var url = constant.apiUrl + "auth/" + mail;
      var res = await api.get(url);
      var resId = res["ID"];
      await store.setUserID(resId);

      // userIdをstoreにset出来てるか確認
      var userID = await store.getUserID();
      setState(() {
        infoText = "Your ID : ${userID}";
      });
      Navigator.pushNamedAndRemoveUntil(
          context, '/my_shift_page', (Route<dynamic> route) => false);
    } catch (e) {
      setState(() {
        infoText = "ログインに失敗しました:${e.toString()}";
      });
    }
  }

  /// 画面描写
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログインページ'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              labelText: 'メールアドレス',
                            ),
                            onChanged: (String value) {
                              setState(() {
                                mail = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 50.0),
                      Container(
                        width: double.infinity,
                        height: 54.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ElevatedButton(
                          child: const Text('ログイン'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                            onPrimary: Colors.white,
                          ),
                          onPressed: () async {
                            signIn();
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        // メッセージ表示
                        child: Text(infoText),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
