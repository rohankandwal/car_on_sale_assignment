import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String token;

  const UserModel({
    required this.name,
    required this.token,
  });

  @override
  List<Object?> get props => [
        name,
        token,
      ];
}
