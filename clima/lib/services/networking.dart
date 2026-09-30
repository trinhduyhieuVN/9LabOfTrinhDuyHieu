import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherException implements Exception {
  const WeatherException(this.message);

  final String message;

  @override
  String toString() => message;
}

class NetworkHelper {
  NetworkHelper({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<dynamic> getData(Uri uri) async {
    late final http.Response response;
    try {
      response = await _client.get(uri, headers: const {
        'Accept': 'application/json'
      }).timeout(const Duration(seconds: 15));
    } on TimeoutException {
      throw const WeatherException('Kết nối quá thời gian. Hãy thử lại.');
    } on http.ClientException {
      throw const WeatherException(
        'Không thể kết nối Internet. Hãy kiểm tra mạng rồi thử lại.',
      );
    }

    if (response.statusCode != 200) {
      throw WeatherException(
        'Dịch vụ thời tiết trả lỗi HTTP ${response.statusCode}. Hãy thử lại sau.',
      );
    }

    try {
      return jsonDecode(response.body);
    } on FormatException {
      throw const WeatherException('Dữ liệu thời tiết trả về không hợp lệ.');
    }
  }
}
