import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class DioExceptionHandler {
  static AppException handle(DioException e) {
    final data = e.response?.data;

    debugPrint('DioException: ${e.type} - ${e.message} - $data');

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400:
            return ValidationException();
          case 404:
            return NotFoundException();
          case 500:
            return ServerException();
          default:
            return const ServerException();
        }
      default:
        return const ServerException();
    }
  }
}
