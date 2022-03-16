
import 'package:dio/dio.dart';

import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/core/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ApiBaseHelper {
  static const String url = 'http://192.168.1.11:8000';

  static BaseOptions opts = BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      connectTimeout: 1000,
      receiveTimeout: 1000,
      headers: {
        // 'Accept': 'application/json',
      });

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
            onRequest: (RequestOptions options, handler) =>
                requestInterceptor(options, handler),
            onError: (DioError e, handler) async {
              return handler.next(e);
            }),
      );
  }

  static dynamic requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    InternetConnectionChecker internetConnectionChecker =
        InternetConnectionChecker();
    //  LocalDataSource localDataSource = LocalDataSource();
    NetworkInfoImpl networkInfoImpl =
        NetworkInfoImpl(internetConnectionChecker);
    if (!await networkInfoImpl.isConnected) {
      handler
          .reject(DioError(requestOptions: options, type: DioErrorType.other));
    }

    // Get your JWT token
    /// await localDataSource.getToken();

    /*if (token.isNotEmpty) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
    }*/
    return handler.next(options);
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  // ignore: missing_return
  Future<Response?> getHTTP(String url) async {
    Response? response;
    try {
      response = await baseAPI.get(url);
      //response.statusCode;
      return response;
    } on DioError catch (e) {
      ExceptionHandling.handleDioExceprion(e);
    }
    return response;
  }

  // ignore: missing_return
  Future<Response> postHTTP(
    String url,
    dynamic data,
  ) async {
    print(url);
    try {
      Response response = await baseAPI.post(url, data: data);
      print(response);
      return response;
    } on DioError catch (e) {
      print(data);
      ExceptionHandling.handleDioExceprion(e);
      rethrow;
    }
  }

  // ignore: missing_return
  Future<Response> postPhotoHTTP(String url, dynamic data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response response = await baseAPI.post(url, data: formData);
      return response;
    } on DioError catch (e) {
      ExceptionHandling.handleDioExceprion(e);
      rethrow;
    }
  }

  // ignore: missing_return
  Future<Response> putHTTP(String url, dynamic data) async {
    try {
      Response response = await baseAPI.put(url, data: data);
      return response;
    } on DioError catch (e) {
      ExceptionHandling.handleDioExceprion(e);
      rethrow;
    }
  }

  // ignore: missing_return
  Future<Response> deleteHTTP(String url) async {
    try {
      Response response = await baseAPI.delete(url);
      return response;
    } on DioError catch (e) {
      ExceptionHandling.handleDioExceprion(e);
      rethrow;
    }
  }
}
