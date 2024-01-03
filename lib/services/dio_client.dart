import 'dart:io';

import 'package:rebustar_driver/utils/exception/generic_exception.dart';
import 'package:rebustar_driver/utils/config/debugger/logger.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/utils.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._();
  static Dio? _dio;

  ApiClient._() {
    Duration millisec = const Duration(milliseconds: 10000);
    _dio = Dio(BaseOptions(connectTimeout: millisec));
    _dio!.options.baseUrl = 'Your Base URL';
    _dio!.interceptors.addAll([
      TokenOnHeaderInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        request: true,
        logPrint: (object) {
          Logger.appLogs("error on dio logger:: $object");
        },
      )
    ]);
  }

  factory ApiClient() => _instance;

  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response;
      response = await _dio!.get(
        url,
        queryParameters: queryParameters,
      );
      final data = response.data;
      Logger.appLogs('responseDio:: $data');

      return data;
    } on DioError catch (error) {
      if (error.response != null) {
        Logger.appLogs('errorDio:: $error');
        throw AppException(error: error, type: ErrorType.dioError, statusCode: error.response!.statusCode);
      }
    } catch (error, stacktrace) {
      Logger.appLogs('errorGetStacktrace:: $stacktrace');
      throw AppException(
        error: error.toString(),
        type: ErrorType.appError,
      );
    }
  }

  Future<dynamic> post(String url, {body}) async {
    try {
      Response response;

      response = await _dio!.post(
        url,
        data: body,
      );
      final data = response.data;
      return data;
    } on DioError catch (error) {
      if (error.response != null) {
        Logger.appLogs('errorDio:: $error');
        throw AppException(error: error, type: ErrorType.dioError, statusCode: error.response!.statusCode);
      }
    } catch (error, stacktrace) {
      Logger.appLogs('errorPostStacktrace:: $stacktrace');
      throw AppException(
        error: error,
        type: ErrorType.appError,
      );
    }
  }

  Future<dynamic> put(String url, {body}) async {
    try {
      Response response;

      response = await _dio!.put(url, data: body);
      final data = response.data;
      return data;
    } on DioError catch (error) {
      if (error.response != null) {
        throw AppException(error: error, type: ErrorType.dioError, statusCode: error.response!.statusCode);
      }
    } catch (error, stacktrace) {
      Logger.appLogs('errorPutStacktrace:: $stacktrace');
      throw AppException(
        error: error,
        type: ErrorType.appError,
      );
    }
  }
}

/// Describes the info of file to upload.
class FileInfo {
  FileInfo(this.file, this.fileName, this.fieldName);

  /// The file to upload.
  final File file;

  /// The file name which the server will receive.
  final String fileName;

  /// This field name will be used in the params for this file
  final String fieldName;
}

class TokenOnHeaderInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      String? token = '';
      /***********************Get your token here****************************/
      //TODO Write your token generation code and pass through the headers

      /********************************************************************/
      options.headers['Authorization'] = 'Bearer $token';
      Logger.appLogs('auth_token:: $token');
      super.onRequest(options, handler);
    } catch (error) {
      AppException(
        error: Strings.checkInternet,
        type: ErrorType.appError,
      );
    }
  }
}
