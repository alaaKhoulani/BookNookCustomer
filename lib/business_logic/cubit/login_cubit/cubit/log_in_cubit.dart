import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/models/user.dart';
import 'package:book_nook_user/data/repository/user_repository.dart';
import 'package:book_nook_user/data/web_services/user_web_services.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:meta/meta.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  UserRepository _userRepository = UserRepository(UserWebServices());

  Future<void> LogIn({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    emit(LogInInSubmitting());
    try {
      String token = await _userRepository.logIn(
          email: email,
          password: password,
          fcmToken: fcmToken);
      if (token != '' && token.isNotEmpty && token!=null){
        Store.store.write('token', token);
        Store.token = token;
        if (isClosed) return;
        emit(LogInSuccess());
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(LogInInFailure(exception: e));
    }
  }
}
