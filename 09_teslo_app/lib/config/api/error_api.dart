import 'package:dio/dio.dart';

class ErrorApi implements DioException {
  @override
  final RequestOptions requestOptions;

  @override
  final Response<dynamic>? response;

  @override
  final DioExceptionType type;

  @override
  final String? message;

  @override
  final dynamic error;

  final StackTrace? _stackTrace;

  ErrorApi({
    required this.requestOptions,
    this.response,
    this.type = DioExceptionType.unknown,
    this.message,
    this.error,
    StackTrace? stackTrace,
  }) : _stackTrace = stackTrace;

  @override
  String toString() {
    return 'ErrorApi: $message';
  }

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) =>
      ErrorApi(
        requestOptions: requestOptions ?? this.requestOptions,
        response: response ?? this.response,
        type: type ?? this.type,
        error: error ?? this.error,
        message: message ?? this.message,
      );

  @override
  StackTrace get stackTrace => _stackTrace ?? StackTrace.empty;

  static var connectionTimeout = DioExceptionType.connectionTimeout;
}
