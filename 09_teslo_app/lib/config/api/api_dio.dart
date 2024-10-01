import 'package:dio/dio.dart';
import 'package:teslo_app/config/api/response_entity.dart';
import 'package:teslo_app/config/constants/environment.dart';

export 'package:dio/dio.dart';

class Api {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future<ResponseEntity> post(String url, {Object? data}) async {
    final response = await dio.post(url, data: data);

    return ResponseEntity(
        message: response.statusMessage ?? 'No message',
        status: response.statusCode ?? 0,
        data: response.data);
  }
}
