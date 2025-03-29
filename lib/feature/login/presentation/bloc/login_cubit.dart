import 'package:assignment_car_on_sale/feature/login/domain/usecases/login_use_case.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/bloc/login_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const int _passwordLength = 6;

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitialState());

  void loginNow({
    required final String email,
    required final String password,
  }) async {
    emit(LoginLoadingState());
    final isValidEmail = EmailValidator.validate(email);
    final isValidPasswordFormat = password.length >= _passwordLength;

    if (!isValidEmail && !isValidPasswordFormat) {
      emit(
        LoginErrorState(
          'Please enter valid email address and password should be more '
          'than ${_passwordLength - 1} characters',
        ),
      );
    } else if (!isValidEmail) {
      emit(
        LoginErrorState(
          'Incorrect Email format, please check',
        ),
      );
    } else if (!isValidPasswordFormat) {
      emit(
        LoginErrorState(
          'Please enter password greater than ${_passwordLength - 1} characters',
        ),
      );
    } else {
      final result = await loginUseCase
          .call(LoginParams(email: email, password: password));
      result.fold((failure) {
        emit(
          LoginErrorState(
            failure.message,
          ),
        );
      }, (isSuccess) {
        if (isSuccess) {
          emit(LoginSuccessState());
        } else {
          LoginErrorState(
            'Something went wrong, please try again',
          );
        }
      });
    }
  }
}
