import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioError error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (data is Map<String, dynamic> && data['message'] != null) {
      return ApiError(message: data['message'], statusCode: statusCode);
    }

    if (statusCode == 302) {
      throw ApiError(message: 'This Email Already Token');
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: 'Connection timeout, please check your internet connction',
        );
      case DioExceptionType.sendTimeout:
        return ApiError(message: 'Request timeout, Plase try again');
      case DioExceptionType.receiveTimeout:
        return ApiError(message: 'Recive Time out');
      case DioExceptionType.badCertificate:
        return ApiError(message: 'bad Certificate');
      case DioExceptionType.badResponse:
        return ApiError(message: 'bad Response in api');
      case DioExceptionType.cancel:
        return ApiError(message: 'try Again');
      case DioExceptionType.connectionError:
        return ApiError(message: 'Connection Error');
      case DioExceptionType.unknown:
        return ApiError(message: 'oops there was error in api');
      default:
        return ApiError(message: 'Somethig went wrong');
    }
  }
}
