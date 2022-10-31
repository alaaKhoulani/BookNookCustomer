import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/repository/user_repository.dart';
import 'package:book_nook_user/data/web_services/user_web_services.dart';
import 'package:meta/meta.dart';

part 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  AddAddressCubit() : super(AddAddressInitial());

  UserRepository _userRepository = UserRepository(UserWebServices());

  Future<void> addAddress(
      {required String title,
      required String area,
      required String street,
      required String floor,
      required String near,
      String details = ''}) async {
    emit(AddAddressSubmitting());
    try {
      bool ok = await _userRepository.addAddress(
          title: title, area: area, street: street, floor: floor, near: near);
      if (ok == true) {
        if (isClosed) return;
        print("hijjjjj");
        emit(AddAddressSuccess());
        return;
      } else {
        emit(AddAddressFailure(exception: Exception()));
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(AddAddressFailure(exception: e));
    }
  }
}
