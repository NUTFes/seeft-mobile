import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:seeft_mobile/configs/importer.dart';

final Api api = Api();

class Api {
  Future post(url, request) async {
    // localhostだとエラー起こるため
    /*
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);

    */
    var req = {"mail": "y.kugue.nutfes@gmail.com", "password": "gidaifes"};
    logger.e(req);
    logger.e(json.encode(req));

    final uri = Uri.parse(url);
    final response = await http.post(
      //final response = await ioClient.post(
      uri,
      body: json.encode(req),
      headers: {
        "Access-Control-Allow-Credentials": "ture",
        "Access-Control-Allow-Headers":
            "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization, accept, origin, Cache-Control, X-Requested-With",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json; charset=utf-8",
        "Date": "Thu, 23 Sep 2021 15:24:15 GMT",
        "X-Cache": "MISS from proxy4.nagaokaut.ac.jp",
        "X-Cache-Lookup": "MISS from proxy4.nagaokaut.ac.jp:8080",
        "Via": "1.1 proxy4.nagaokaut.ac.jp (squid/3.5.27)",
        "Connection": "keep-alive",
      },
    );

    if (response.statusCode == 200) {
      logger.e('success posted.');
      return json.decode(response.body);
    } else {
      logger.e('failed posted.');
      throw Exception('Failed POST in Api.post()');
    }
  }

  Future get(url) async {
    // debug
    // bool trustSelfSigned = true;
    // HttpClient httpClient = new HttpClient()
    //   ..badCertificateCallback =
    //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
    // IOClient ioClient = new IOClient(httpClient);
    final uri = Uri.parse(url);
    final response = await http.get(uri);
//    final response = await ioClient.get(url);

    if (response.statusCode == 200) {
      logger.d('success get');
      return json.decode(response.body);
    } else {
      logger.e('failed get');
      throw Exception('Failed GET in Api.get()');
    }
  }

// Example
  Future getMyShift(id) async {
    String url = constant.apiUrl + 'shift/' + id;
    try {
      return await get(url);
    } catch (err) {
      logger.e(err);
      // calling api.get みたいに呼び出し元参照できるようにしたい
      throw err;
    }
  }

  // POST Sign In
  Future postSignIn(request) async {
    String url = constant.apiUrl + 'auth';
    try {
      return await post(url, request);
    } catch (err) {
      logger.e(err);
      throw err;
    }
  }
}
