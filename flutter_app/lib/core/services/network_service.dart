import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import 'storage_service.dart';

class NetworkService {
  static late Dio _dio;
  
  static void init() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    // 添加拦截器
    _dio.interceptors.add(_AuthInterceptor());
    
    // 只在调试模式下添加日志拦截器
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ));
    }
    
    // 添加错误处理拦截器
    _dio.interceptors.add(_ErrorInterceptor());
  }
  
  static Dio get dio => _dio;
  
  // GET 请求
  static Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  // POST 请求
  static Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  // PUT 请求
  static Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  // DELETE 请求
  static Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  // 文件上传
  static Future<Response> upload(
    String path,
    String filePath, {
    String? fileName,
    Map<String, dynamic>? data,
  }) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      ...?data,
    });
    
    return _dio.post(
      path,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }
}

// 认证拦截器
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 添加token到请求头
    final token = StorageService.getUserToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['USERTOKEN'] = token;
    }
    
    // 添加语言信息
    options.headers['lang'] = 'zh-CN';
    
    super.onRequest(options, handler);
  }
}

// 错误处理拦截器
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 统一错误处理
    String errorMessage = '';
    
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = '连接超时';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = '请求超时';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = '响应超时';
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        switch (statusCode) {
          case 401:
            errorMessage = '未授权，请重新登录';
            // 清除token并跳转到登录页面
            StorageService.clearUserToken();
            break;
          case 403:
            errorMessage = '禁止访问';
            break;
          case 404:
            errorMessage = '请求资源不存在';
            break;
          case 500:
            errorMessage = '服务器内部错误';
            break;
          default:
            errorMessage = '请求失败，错误码：$statusCode';
        }
        break;
      case DioExceptionType.cancel:
        errorMessage = '请求已取消';
        break;
      case DioExceptionType.connectionError:
        errorMessage = '网络连接失败';
        break;
      default:
        errorMessage = '未知错误：${err.message}';
    }
    
    // 创建自定义错误
    final customError = DioException(
      requestOptions: err.requestOptions,
      message: errorMessage,
      type: err.type,
      response: err.response,
    );
    
    super.onError(customError, handler);
  }
}

// API响应包装类
class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;
  final bool success;
  
  ApiResponse({
    required this.code,
    required this.message,
    this.data,
    required this.success,
  });
  
  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic)? fromJsonT) {
    return ApiResponse<T>(
      code: json['code'] ?? 0,
      message: json['msg'] ?? json['message'] ?? '',
      data: json['data'] != null && fromJsonT != null ? fromJsonT(json['data']) : json['data'],
      success: json['status'] == 0 || json['code'] == 200,
    );
  }
}

// 网络异常类
class NetworkException implements Exception {
  final String message;
  final int? code;
  
  NetworkException(this.message, [this.code]);
  
  @override
  String toString() => 'NetworkException: $message';
} 