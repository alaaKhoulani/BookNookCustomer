import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/repository/user_repository.dart';
import 'package:book_nook_user/data/web_services/user_web_services.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());

  UserRepository _userrepository = UserRepository(UserWebServices());

  Future<void> logOut() async {
    emit(LogOutSubmetting());
    bool ok = await _userrepository.logOut();
    if (ok == true) {
      Store.store.remove('token');
      Store.token = null;
      emit(LogOutSuccessful());
    } else
      emit(LogOutFailure(exception: Exception()));
  }
}
