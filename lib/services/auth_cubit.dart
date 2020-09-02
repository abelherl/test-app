import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/services/data_dummy.dart';
import 'package:test_app/services/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void tryLogin(String phone, String password) {
    bool found = false;
    print(phone);
    AuthState state;
    userDummyList.forEach((item) {
      print(item.phone);
      if (phone == item.phone) {
        found = true;
        if (item.password == item.password) {
          state = SuccessState(item);
        }
        else {
          state = FailedState("Wrong password", "");
        }
      }
    });
    if (!found) {
      state = FailedState("User not found", "");
    }
    emit(state);
  }

  void tryRegister(String name, String email, String address, String birthdate) {
    AuthState state;
    final emailValidator = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    print("Registering");

    if (name.length > 5) {
      if (emailValidator.hasMatch(email)) {
        if (address.isNotEmpty) {
          if (birthdate.isNotEmpty) {
            state = SuccessState(User(name: name));
          }
        }
        else {
          state = FailedState("Please enter an address", "address");
        }
      }
      else {
        state = FailedState("Please enter a valid email", "email");
      }
    }
    else {
      state = FailedState("Please enter more than 5 characters", "name");
    }

    emit(state);
  }

  void isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('is_logged_in');
    AuthState state = AuthInitial();

    if (isLoggedIn) {
      final name = prefs.getString('user_name');
      User user = User(name: name,);
      state = SuccessState(user);
    }

    emit(state);
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_logged_in', false);

    emit(AuthInitial());
  }
}
