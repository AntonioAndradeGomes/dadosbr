abstract class AppException implements Exception {
  final String name;
  final String message;
  final String type;

  const AppException({
    required this.name,
    required this.message,
    required this.type,
  });
}

class ValidationException extends AppException {
  const ValidationException({String? message})
    : super(
        name: 'BadRequestError',
        message: message ?? 'Requisição inválida.',
        type: 'validation_error',
      );
}

class NotFoundException extends AppException {
  const NotFoundException({String? message})
    : super(
        name: 'NotFoundError',
        message: message ?? 'Registro não encontrado.',
        type: 'service_error',
      );
}

class ServerException extends AppException {
  const ServerException({String? message})
    : super(
        name: 'InternalError',
        message: message ?? 'Erro interno do servidor. Tente novamente.',
        type: 'internal_error',
      );
}

class NetworkException extends AppException {
  const NetworkException({String? message})
    : super(
        name: 'NetworkError',
        message: message ?? 'Sem conexão. Verifique sua internet.',
        type: 'network_error',
      );
}

class TimeoutException extends AppException {
  const TimeoutException({String? message})
    : super(
        name: 'TimeoutError',
        message: message ?? 'Tempo esgotado. Tente novamente.',
        type: 'timeout_error',
      );
}
