import 'package:dio/dio.dart';
import 'package:teslo_app/config/config.dart';

class Api {
  final String? accessToken;
  late final Dio _dio;

  Api({this.accessToken})
      : _dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {'Authorization': 'Bearer $accessToken'},
        ));

  Future<ResponseEntity<T>> request<T>(
    String url, {
    Object? data,
    String? method,
  }) async {
    return _handleExceptions(() async {
      final response = await _dio.request<T>(url,
          data: data, options: Options(method: method));

      return ResponseEntity<T>(
        message: response.statusMessage ?? 'No message',
        status: response.statusCode ?? 0,
        data: response.data as T,
      );
    });
  }

  Future<ResponseEntity<T>> post<T>(String url, {Object? data}) async {
    return _handleExceptions(() async {
      final response = await _dio.post<T>(url, data: data);

      return ResponseEntity<T>(
        message: response.statusMessage ?? 'No message',
        status: response.statusCode ?? 0,
        data: response.data as T,
      );
    });
  }

  Future<ResponseEntity<T>> get<T>(String url) async {
    return _handleExceptions(() async {
      final response = await _dio.get<T>(url);

      return ResponseEntity<T>(
        message: response.statusMessage ?? 'No message',
        status: response.statusCode ?? 0,
        data: response.data as T,
      );
    });
  }

  Future<ResponseEntity<T>> _handleExceptions<T>(
      Future<ResponseEntity<T>> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw ErrorApi(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        message: e.message,
        error: e.error,
        stackTrace: e.stackTrace,
      );
    } catch (e) {
      throw ErrorApi(
        requestOptions: RequestOptions(path: ''),
        message: e.toString(),
        type: DioExceptionType.unknown,
        stackTrace: StackTrace.current,
      );
    }
  }
}
