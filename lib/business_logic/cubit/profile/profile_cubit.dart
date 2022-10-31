import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/models/user.dart';
import 'package:book_nook_user/data/repository/user_repository.dart';
import 'package:book_nook_user/data/web_services/user_web_services.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  UserRepository _userRepository = UserRepository(UserWebServices());

  Future<void> profile() async {
    try {
      emit(ProfileSubmitting());
      User user = await _userRepository.profle();
      if (user != null) {
        Store.store.write('user', user);
        Store.myUser = user;
        // print(Store.myAdmin.image!);
        print("user");
        print(user.email);
        if (isClosed) return;
        emit(ProfileSuccess(admin: user));
      } else {
        emit(ProfileFailure(exception: Exception()));
      }
    } on Exception catch (e) {
      // return Admin();
      emit(ProfileFailure(exception: e));
    }
  }
}
