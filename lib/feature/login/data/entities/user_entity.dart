import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String token;

  const UserEntity({
    required this.name,
    required this.token,
  });

  @override
  List<Object?> get props => [
        name,
        token,
      ];
}
