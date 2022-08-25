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

    final uri = Uri.parse(url);
    logger.i(uri);
    logger.i(json.encode(request));
    final response = await http.post(
      //final response = await ioClient.post(
      uri,
      body: json.encode(request),
      headers: {
        //HttpHeaders.contentTypeHeader: 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        //"Content-Length": "<calculated when request is sent>",
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
    // final response = await ioClient.get(url);

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

  // 準備日シフト
  Future getMyShiftPreparationDay(id) async {
    String url = constant.apiUrl + 'shift/' + id + '/preparationDay';
    try {
      return await get(url);
    } catch (err) {
      logger.e(err);
      // calling api.get みたいに呼び出し元参照できるようにしたい
      throw err;
    }
  }

  // 当日シフト
  Future getMyShiftCurrentDay(id) async {
    String url = constant.apiUrl + 'shift/' + id + '/currentDay';
    try {
      return await get(url);
    } catch (err) {
      logger.e(err);
      // calling api.get みたいに呼び出し元参照できるようにしたい
      throw err;
    }
  }

  // 準備日晴れシフト
  Future getMyShiftPreparationDaySunny(id) async {
    String url = constant.apiUrl + 'shift/' + id + '/preparationDay' + '/sunny';
    try {
      return await get(url);
    } catch (err) {
      logger.e(err);
      // calling api.get みたいに呼び出し元参照できるようにしたい
      throw err;
    }
  }

  // 準備日雨シフト
  Future getMyShiftPreparationDayRainy(id) async {
    String url = constant.apiUrl + 'shift/' + id + '/preparationDay' + '/rainy';
    try {
      return await get(url);
    } catch (err) {
      logger.e(err);
      // calling api.get みたいに呼び出し元参照できるようにしたい
      throw err;
    }
  }

  // 当日晴れシフト
  Future getMyShiftCurrentDaySunny(id) async {
    String url = constant.apiUrl + 'shift/' + id + '/currentDay' + '/sunny';
    try {
      return await get(url);
    } catch (err) {
      logger.e(err);
      // calling api.get みたいに呼び出し元参照できるようにしたい
      throw err;
    }
  }

  // 当日雨シフト
  Future getMyShiftCurrentDayRainy(id) async {
    String url = constant.apiUrl + 'shift/' + id + '/currentDay' + '/rainy';
    try {
      return await get(url);
    } catch (err) {
      logger.e(err);
      // calling api.get みたいに呼び出し元参照できるようにしたい
      throw err;
    }
  }

  // 片付け日シフト
  Future getMyShiftCleanupDay(id) async {
    String url = constant.apiUrl + 'shift/' + id + '/cleanupDay';
    try {
      return await get(url);
    } catch (err) {
      logger.e(err);
      // calling api.get みたいに呼び出し元参照できるようにしたい
      throw err;
    }
  }

  // マニュアル一覧
  Future getAllManual() async {
    String url = constant.apiUrl + 'work/list';
    try {
      return await get(url);
    } catch (err) {
      logger.e(err);
      // calling api.get みたいに呼び出し元参照できるようにしたい
      throw err;
    }
  }

  // POST Sign In (リダイレクションエラーが返ってくるため不使用)
  Future postSignIn(request) async {
    var url = Uri.parse(constant.apiUrl + 'auth');
    var response = await http.post(url,
        body: {'mail': 'y.kugue.nutfes@gmail.com', 'password': 'gidaifes'});

    if (response.statusCode == 200) {
      logger.i('success posted.');
      return json.decode(response.body);
    } else {
      logger.e('failed posted.');
      throw Exception('Failed POST in Api.post()');
    }
  }

  // Get Sign In
  Future signIn(mail) async {
    try {
      var url = constant.apiUrl + "auth/signin/" + mail;
      return await api.get(url);
    } catch (e) {
      logger.e('failed got.');
      throw Exception('Failed GET in Api.signIn()');
    }
  }

  // Get Shift Detail
  Future shiftDetail(workId, userId, date, weather, time) async {
    logger.w(time);
    var url = constant.apiUrl +
        "/work/" +
        workId.toString() +
        "/" +
        userId.toString() +
        "/" +
        date +
        "/" +
        weather +
        "/" +
        time;
    logger.w(url);
    try {
      var res = await get(url);
      logger.i(res);
      return await get(url);
    } catch (e) {
      logger.e('failed got.');
      throw Exception('Failed GET in Api.workDetail()');
    }
  }
}
