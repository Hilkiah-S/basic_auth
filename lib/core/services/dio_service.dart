import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:auth/core/constants/api_config.dart';
import 'package:auth/config/util/error/apifailure.dart';
import 'package:auth/config/util/error/failure.dart';
import 'package:auth/config/typedef.dart';

class DioService {
  static Dio? _dioInstance = Dio(
    BaseOptions(
      baseUrl: APIConfig.baseURLHttps,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(minutes: 3),
      receiveTimeout: const Duration(minutes: 3),
    ),
  );

  static void _initializeInterceptors({
    bool isFormUrl = false,
    String? accessToken,
  }) {
    // Clear existing interceptors
    _dioInstance?.interceptors.clear();

    // Add new interceptor with provided parameters
    _dioInstance?.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['accept'] = 'application/json';
          options.headers['Content-Type'] = isFormUrl
              ? 'application/x-www-form-urlencoded;charset=utf-8'
              : 'application/json;charset=utf-8';
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }

          options.headers['X-Content-Type-Options'] = 'nosniff';
          options.headers['X-Frame-Options'] = 'DENY';
          options.headers['X-XSS-Protection'] = '1; mode=block';

          return handler.next(options);
        },
        // Add onResponse and onError if needed
      ),
    );
  }

  static FutureResult<Map<String, dynamic>> post({
    required String path,
    Map<String, dynamic>? data,
    bool isFormUrl = false,
    String? accessToken,
  }) async {
    try {
      _initializeInterceptors(isFormUrl: isFormUrl, accessToken: accessToken);
      Logger().d("${_dioInstance?.options.baseUrl}$path");
      Logger().d(data);
      final response = await _dioInstance?.post(path, data: data);
      Logger().d(response?.data);

      return Right(response?.data as Map<String, dynamic>);
    } on DioException catch (e) {
      Logger().e(e);
      // Logger().e(e.response);
      // Logger().e(e.requestOptions.path);

      return Left(ApiFailure(message: e.toString()));
    } catch (e) {
      Logger().e(e);

      return Left(ApiFailure(message: e.toString()));
    }
  }

  static FutureResult<Map<String, dynamic>> postFile({
    required String path,
    FormData? data,
    bool isFormUrl = false,
    String? accessToken,
  }) async {
    try {
      _initializeInterceptors(isFormUrl: isFormUrl, accessToken: accessToken);
      Logger().d("${_dioInstance?.options.baseUrl}$path");
      Logger().d(data);
      final response = await _dioInstance?.post(path, data: data);
      Logger().d(response?.data);

      return Right(response?.data as Map<String, dynamic>);
    } on DioException catch (e) {
      Logger().e(e);
      // Logger().e(e.response);
      // Logger().e(e.requestOptions.path);

      return Left(ApiFailure(message: e.toString()));
    } catch (e) {
      Logger().e(e);

      return Left(ApiFailure(message: e.toString()));
    }
  }

  static FutureResult<Map<String, dynamic>> get({
    required String path,
    Map<String, dynamic>? queryParameter,
    bool isFormUrl = false,
    String? accessToken,
  }) async {
    try {
      _initializeInterceptors(isFormUrl: isFormUrl, accessToken: accessToken);
      Logger().d("${_dioInstance?.options.baseUrl}$path");
      Logger().d(queryParameter);
      final response = await _dioInstance?.get(
        path,
        queryParameters: queryParameter,
      );

      return Right(response?.data as Map<String, dynamic>);
    } on DioException catch (e) {
      Logger().e(e);
      Logger().e(e.response);
      Logger().e(e.requestOptions.queryParameters);

      return Left(ApiFailure(message: e.toString()));
    } catch (e) {
      Logger().e(e);

      return Left(ApiFailure(message: e.toString()));
    }
  }
}
