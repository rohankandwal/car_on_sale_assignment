import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginSuccessState extends LoginState {}
