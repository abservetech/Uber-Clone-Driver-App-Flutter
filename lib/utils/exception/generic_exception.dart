
import '../utils.dart';

class GenericException implements Exception {
  final String message;

  GenericException(this.message);
}

class AppException implements Exception {
  final Object error;
  final ErrorType type;
  final int? statusCode;

  AppException({required this.error, required this.type, this.statusCode});
}
