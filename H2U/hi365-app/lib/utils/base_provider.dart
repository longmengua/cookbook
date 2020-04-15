import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

/// Skeleton of http service
///
/// User could input the option to set up a customized http service,
/// baseUrl field in [options] cannot be null
class BaseProvider {
  final BaseOptions _options;
  Dio client;

  BaseProvider({
    @required BaseOptions options,
  })  : assert(options.baseUrl != null),
        _options = options {
    client = Dio(_options);
    _toInitInterceptors();
  }

  void _toInitInterceptors() {
    client.interceptors.add(LogInterceptor(responseBody: false));
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          return options;
        },
        onResponse: (Response response) {
          print('ressponse from ${_options.baseUrl}, with data:\n$response');
          return response;
        },
        onError: (DioError e) {
          return e;
        },
      ),
    );
  }
}
