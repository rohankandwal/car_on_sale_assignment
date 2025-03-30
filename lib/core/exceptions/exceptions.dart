// Exceptions from server in data layer
import 'package:equatable/equatable.dart';

sealed class BaseException extends Equatable implements Exception {
  final String message;

  const BaseException(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}

/// If the request headers are missing, we throw [AuthenticationException].
class AuthenticationException extends BaseException {
  const AuthenticationException(super.message);
}

/// In case there is a serialization issue, we throw [ParsingException]
class ParsingException extends BaseException {
  const ParsingException(super.message);
}

/// In case we get network error eg - Timeout, 404, we throw [NetworkException]
class NetworkException extends BaseException {
  const NetworkException(super.message);
}

/// In case we get 500 error from server, we throw [ServerException]
class ServerException extends BaseException {
  const ServerException(super.message);
}
