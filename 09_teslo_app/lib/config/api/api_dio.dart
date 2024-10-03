import 'package:dio/dio.dart';
import 'package:teslo_app/config/api/response_entity.dart';
import 'package:teslo_app/config/constants/environment.dart';

export 'package:dio/dio.dart';

class Api {
  final String? accessToken;
  late final Dio _dio;

  Api({this.accessToken})
      : _dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {'Authorization': 'Bearer $accessToken'},
        ));

  Future<ResponseEntity<T>> post<T>(String url, {Object? data}) async {
    final response = await _dio.post<T>(url, data: data);

    return ResponseEntity(
      message: response.statusMessage ?? 'No message',
      status: response.statusCode ?? 0,
      data: response.data as T,
    );
  }

  Future<ResponseEntity<T>> get<T>(String url, {Options? options}) async {
    final response = await _dio.get<T>(url, options: options);

    return ResponseEntity<T>(
      message: response.statusMessage ?? 'No message',
      status: response.statusCode ?? 0,
      data: response.data as T,
    );
  }
}
