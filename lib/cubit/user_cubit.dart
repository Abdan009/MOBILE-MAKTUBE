import 'package:bloc/bloc.dart';
import 'package:maktube/model/models.dart';
import 'package:maktube/services/services.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  SharedPreferences localStorage;

  void toUserLoaded() {
    emit(UserLoaded(null));
  }

  Future<User> login(String username, String password) async {
    User user = await UserServices().login(username, password);
    if (user != null) {
      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('username', username);
      localStorage.setString('password', password);
    }
    emit(UserLoaded(user));
    return user;
  }

  Future<void> logout() async {
    localStorage = await SharedPreferences.getInstance();
    localStorage.remove('username');
    localStorage.remove('password');
    emit(UserLoaded(null));
  }

  Future<User> register(User user) async {
    User result = await UserServices().createUser(user);
    if (result != null) {
      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('username', user.username);
      localStorage.setString('password', user.password);
    }

    emit(UserLoaded(result));
    return result;
  }
}
