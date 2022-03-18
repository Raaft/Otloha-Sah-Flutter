import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base/core/data/chash_helper.dart';

import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/core/network/network_info.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'RefreshTokenModel.dart';

class ApiBaseHelper {
  static const String url = baseUrl;

  // static const String url = 'http://46.101.113.121';

  static BaseOptions opts = BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      headers: {
        'content-type': 'application/json',
        'Accept': 'application/json',
      });

  
  static Dio createDio() {
    return Dio(opts);
  }

  static retryRequest(RequestOptions? currentRequestOptions) {
    currentRequestOptions!.headers[HttpHeaders.authorizationHeader] =
        'Bearer ' + CacheHelper.getData(key: 'token');
    return dio
        .request(
          currentRequestOptions.path,
          cancelToken: currentRequestOptions.cancelToken,
          data: currentRequestOptions.data,
          onReceiveProgress: currentRequestOptions.onReceiveProgress,
          onSendProgress: currentRequestOptions.onSendProgress,
          queryParameters: currentRequestOptions.queryParameters,
          options: Options(
            method: currentRequestOptions.method,
            sendTimeout: currentRequestOptions.sendTimeout,
            receiveTimeout: currentRequestOptions.receiveTimeout,
            extra: currentRequestOptions.extra,
            headers: currentRequestOptions.headers,
            responseType: currentRequestOptions.responseType,
            contentType: currentRequestOptions.contentType,
            validateStatus: currentRequestOptions.validateStatus,
            receiveDataWhenStatusError:
                currentRequestOptions.receiveDataWhenStatusError,
            followRedirects: currentRequestOptions.followRedirects,
            maxRedirects: currentRequestOptions.maxRedirects,
            requestEncoder: currentRequestOptions.requestEncoder,
            responseDecoder: currentRequestOptions.responseDecoder,
            listFormat: currentRequestOptions.listFormat,
          ),
        )
        .whenComplete(() => print('complete'));
  }

  static Dio addInterceptors(Dio dio) {
    RequestOptions? currentRequestOptions;
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options, handler) {
            print('headers ${options.headers}');
            if (options.path != '/api/v1/token/refresh/') {
              print('path ${options.path}');
              currentRequestOptions = options;
            }
            requestInterceptor(options, handler);
          },
          onError: (DioError e, handler) async {
            String currentToken = await CacheHelper.getData(key: 'token') ?? '';
            print('asdasdaskldlaskm $currentToken');
            if (currentToken.isNotEmpty && e.response!.statusCode == 401) {
              String refreshToken = CacheHelper.getData(key: 'refresh');
              var response = await baseAPI.post('/api/v1/token/refresh/',
                  data: {'refresh': refreshToken});
              print('response  ${response.data}');
              RefreshTokenModel? t = RefreshTokenModel.fromJson(response.data);
              CacheHelper.saveData(key: 'token', value: t.access);
              return await retryRequest(currentRequestOptions);
            } else {
              return handler.next(e);
            }
          },
        ),
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
    String accessToken = CacheHelper.getData(key: 'token');
    if (accessToken.isNotEmpty) {
      options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ' + accessToken;
    }
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
    dynamic data, {
    bool? isAuth,
  }) async {
    if (isAuth ?? false) {
      ApiBaseHelper.baseAPI.options.headers[HttpHeaders.authorizationHeader] =
          '';
    }
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

class ApiBaseHelperForAuth {
  static const String url = baseUrl;

  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    headers: {},
  );


  ///
  static Dio createDio() {
    return Dio(opts);
  }

  static retryRequest(RequestOptions? currentRequestOptions) {
    dio.request(
      currentRequestOptions!.path,
      cancelToken: currentRequestOptions.cancelToken,
      data: currentRequestOptions.data,
      onReceiveProgress: currentRequestOptions.onReceiveProgress,
      onSendProgress: currentRequestOptions.onSendProgress,
      queryParameters: currentRequestOptions.queryParameters,
      options: Options(
        method: currentRequestOptions.method,
        sendTimeout: currentRequestOptions.sendTimeout,
        receiveTimeout: currentRequestOptions.receiveTimeout,
        extra: currentRequestOptions.extra,
        headers: currentRequestOptions.headers,
        responseType: currentRequestOptions.responseType,
        contentType: currentRequestOptions.contentType,
        validateStatus: currentRequestOptions.validateStatus,
        receiveDataWhenStatusError:
            currentRequestOptions.receiveDataWhenStatusError,
        followRedirects: currentRequestOptions.followRedirects,
        maxRedirects: currentRequestOptions.maxRedirects,
        requestEncoder: currentRequestOptions.requestEncoder,
        responseDecoder: currentRequestOptions.responseDecoder,
        listFormat: currentRequestOptions.listFormat,
      ),
    );
  }

  static Dio addInterceptors(Dio dio) {
    RequestOptions? currentRequestOptions;

    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options, handler) {
            currentRequestOptions = options;
            requestInterceptor(options, handler);
          },
          onError: (DioError e, handler) async {
            String currentToken = await CacheHelper.getData(key: 'token') ?? '';
            print('asdasdaskldlaskm $currentToken');
            if (currentToken.isNotEmpty && e.response!.statusCode == 401) {
              print('hey');
              String refreshToken = CacheHelper.getData(key: 'refresh');
              var response = await baseAPI.post('/api/v1/token/refresh/',
                  data: {'refresh': refreshToken});
              print(response.data);
              RefreshTokenModel? t = RefreshTokenModel.fromJson(response.data);
              token = t.access!;
              await retryRequest(currentRequestOptions);
            } else {
              return handler.next(e);
            }
          },
        ),
      );
  }

  static dynamic requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    InternetConnectionChecker internetConnectionChecker =
        InternetConnectionChecker();
    NetworkInfoImpl networkInfoImpl =
        NetworkInfoImpl(internetConnectionChecker);
    if (!await networkInfoImpl.isConnected) {
      handler
          .reject(DioError(requestOptions: options, type: DioErrorType.other));
    }

    return handler.next(options);
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  // ignore: missing_return
  Future<Response?> getHTTP(String url) async {
    Response? response;
    try {
      response = await baseAPI.get(url);
      return response;
    } on DioError catch (e) {
      ExceptionHandling.handleDioExceprion(e);
    }
    return response;
  }

  // ignore: missing_return
  Future<Response> postHTTP(
    String url,
    dynamic data, {
    bool? isAuth,
  }) async {
    if (isAuth ?? false) {
      ApiBaseHelper.baseAPI.options.headers[HttpHeaders.authorizationHeader] =
          '';
    }
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
