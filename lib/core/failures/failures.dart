import 'package:equatable/equatable.dart';

sealed class BaseFailure extends Equatable {
  final String message;

  const BaseFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends BaseFailure {
  const ServerFailure(super.message);
}

class CacheFailure extends BaseFailure {
  const CacheFailure(super.message);
}
