import 'dart:developer';

import 'package:seeft_mobile/configs/importer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

/// 利用者登録のページ
class _SignInPageState extends State<SignInPage> {
  String mail = '';
  String password = '';
  String infoText = '';

  /// 画面描写
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
        backgroundColor: Colors.green[300],
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
                              labelText: 'Mail',
                            ),
                            onChanged: (String value) {
                              setState(() {
                                mail = value;
                              });
                            },
                          ),
                          const SizedBox(height: 24.0),
                          // パスワードの入力フォーム
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              labelText: 'Password',
                            ),
                            onChanged: (String value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 54.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ElevatedButton(
                          child: const Text('Sign In'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green[300],
                            onPrimary: Colors.white,
                          ),
                          onPressed: () async {
                            String url = constant.apiUrl + 'auth';

                            try {
                              var request = {
                                "mail": mail,
                                "password": password
                              };
                              var res = await api.post(url, request);

                              setState(() {
                                infoText = "ログイン:${res.body}";
                              });
                            } catch (e) {
                              setState(() {
                                infoText = "ログインに失敗しました:${e.toString()}";
                              });
                            }
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
/*
/// 利用者登録のページ
class _SignInPageState extends State<SignInPage> {
  String email = '';
  String password = '';
  String infoText = '';

  /// 画面描写
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Sign In'),
        ),
        //title: Image.asset("../../assets/logo.png"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Mail'),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                padding: EdgeInsets.all(8),
                // メッセージ表示
                child: Text(infoText),
              ),
              Container(
                width: double.infinity,
                // ログイン登録ボタン
                child: ElevatedButton(
                  child: Text('Log In'),
                  onPressed: () async{
                    /*
                    try {
                      // メール/パスワードでログイン
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      // ログインに成功した場合
                      // チャット画面に遷移＋ログイン画面を破棄
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return ChatPage();
                        }),
                      );
                    } catch (e) {
                      setState(() {
                        infoText = "ログインに失敗しました：${e.toString()}";
                      });
                    }
                    */
                  },
                ),
              ),
            ],
          )
        )
      ),
    ),
  }
}
*/