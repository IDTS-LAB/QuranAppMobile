sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;
  @override
  String toString() => '$runtimeType: $message';
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message);
}

class ForbiddenException extends AppException {
  const ForbiddenException(super.message);
}

class NotFoundException extends AppException {
  const NotFoundException(super.message);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}

class ServerException extends AppException {
  const ServerException(super.message);
}

class TimeoutException extends AppException {
  const TimeoutException(super.message);
}

class ConnectionException extends AppException {
  const ConnectionException(super.message);
}

class DatabaseException extends AppException {
  const DatabaseException(super.message);
}

class CacheException extends AppException {
  const CacheException(super.message);
}

class UnknownException extends AppException {
  const UnknownException(super.message);
}
