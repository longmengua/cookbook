import 'package:dio/dio.dart';

class DioFactory {
  Dio _dio;
  Dio _formDio;

  DioFactory() {
    ///   var dio = Dio(BaseOptions(
    ///    baseUrl: "http://www.dtworkroom.com/doris/1/2.0.0/",
    ///    connectTimeout: 5000,
    ///    receiveTimeout: 5000,
    ///    headers: {HttpHeaders.userAgentHeader: 'dio', 'common-header': 'xx'},
    ///   ));
    this._dio = Dio();
    this._formDio = Dio()
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (option) => option
          ..headers = {"content-type": "application/x-www-form-urlencoded"},
      ));
    addInterceptors();
  }

  Dio get getDio => _dio;

  Dio get getFormDio => _formDio;

  void addInterceptors() {
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
//    dio.interceptors.add(
//      InterceptorsWrapper(
//        onRequest: (RequestOptions options) {
//          return options;
//        },
//        onResponse: (Response response) {
//          return response;
//        },
//        onError: (DioError e) {
//          return e;
//        },
//      ),
//    );
  }
}
