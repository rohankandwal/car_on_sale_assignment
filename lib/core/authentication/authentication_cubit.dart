import 'package:assignment_car_on_sale/core/authentication/authentication_state.dart';
import 'package:assignment_car_on_sale/core/local_storage/shared_pref.dart';
import 'package:assignment_car_on_sale/core/utils/string_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SharedPref _sharedPref;

  AuthenticationCubit(this._sharedPref) : super(AuthenticationInitialState());

  void checkIfUserAuthenticated() async {
    final userData = await _sharedPref.getString(
      key: StringConstants.userInfoKey,
    );
    if (userData != null) {
      emit(UserAuthorizedState());
    } else {
      emit(UserNotAuthorizedState());
    }
  }
}
