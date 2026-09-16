import 'dart:convert';

/// Базовое исключение для API
abstract class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

/// Ошибка при отсутствии интернета или таймауте
class NetworkException extends ApiException {
  NetworkException([String message = 'Отсутствует подключение к интернету']) : super(message);
}

/// Ошибка сервера (например, 400 Bad Request с телом из Swagger)
class ServerException extends ApiException {
  final int statusCode;
  final Map<String, dynamic>? errorData;

  ServerException({required this.statusCode, required String message, this.errorData}) : super(message);

  factory ServerException.fromJson(int statusCode, String body) {
    try {
      final json = jsonDecode(body);
      return ServerException(
        statusCode: statusCode,
        message: json['message'] ?? 'Ошибка сервера',
        errorData: json['data'],
      );
    } catch (_) {
      return ServerException(statusCode: statusCode, message: 'Неизвестная ошибка сервера: $body');
    }
  }
}

/// Ошибка отсутствия авторизации (401)
class UnauthorizedException extends ApiException {
  UnauthorizedException([super.message = 'Пользователь не авторизован']);
}
