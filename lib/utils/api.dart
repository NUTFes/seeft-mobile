import 'package:http/io_client.dart';
import 'package:seeft_mobile/configs/importer.dart';

final Api api = Api();

class Api {
  Future post(url, request) async {
    // localhostだとエラー起こるため
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);

//    final response = await http.(
    final response = await ioClient.post(
      url,
      body: json.encode(request),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      logger.e('success posted.');
      return json.decode(response.body);
    } else {
      logger.e('failed posted.');
      throw Exception('Failed POST in Api.post()');
    }
  }

  Future get(url, request) async {
    // debug
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);

//    final response = await http.(
    final response = await ioClient.post(
      url,
      body: json.encode(request),
      headers: {"Content-Type": "application/json"},
    );

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
    Map<String, dynamic> request = {'id': id};
    String url = constant.apiUrl + 'myshift';
    try {
      return await get(url, request);
    } catch (err) {
      // calling api.get みたいに呼び出し元参照できるようにしたい
      throw err;
    }
  }
}
