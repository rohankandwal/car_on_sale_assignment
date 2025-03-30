import 'package:equatable/equatable.dart';

sealed class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class UserAuthorizedState extends AuthenticationState {}

class UserNotAuthorizedState extends AuthenticationState {}
