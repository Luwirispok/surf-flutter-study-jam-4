import 'package:dio/dio.dart';

class ApiHelper {
  static final Dio _dio = Dio();
  static final Map<String, dynamic> headerDefault = {'Accept': 'application/json'};

  static Future<dynamic> get(
      {required String path, Map<String, dynamic>? queryParameters, Map<String, dynamic>? header}) async {
    try {
      Response<dynamic> response =
          await _dio.get(path, options: Options(headers: header ?? headerDefault), queryParameters: queryParameters);
      final String statusCode = response.statusCode.toString();
      if (statusCode.startsWith('2')) {
        return response.data;
      } else if (statusCode == '404') {
        throw Exception('Не найдено: ошибка ${response.statusCode}');
      } else if (statusCode == '401' || statusCode == '403') {
        throw Exception('Проблема авторизации: ошибка ${response.statusCode}');
      } else {
        throw Exception('Ошибка ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Упс... ${e.toString()}');
    }
  }
}
