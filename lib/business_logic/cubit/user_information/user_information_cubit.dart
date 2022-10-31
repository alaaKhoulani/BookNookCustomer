import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/repository/user_repository.dart';
import 'package:book_nook_user/data/web_services/user_web_services.dart';
import 'package:meta/meta.dart';
part 'user_information_state.dart';

class UserInformationCubit extends Cubit<UserInformationState> {
  UserInformationCubit() : super(UserInformationInitial());

  UserRepository _adminRepository = UserRepository(UserWebServices());

  Future<void> submitInformation(
      {required String firstName,
      required String middleName,
      required String lastyName,
      required String phonNumber,
      required String gender,
      required String dateBirthDay}) async {
    try {
      emit(UserInformationSubmitting());
      bool ok = await _adminRepository.submitInformation(
          firstName: firstName,
          middleName: middleName,
          lastyName: lastyName,
          phonNumber: phonNumber,
          gender: gender,
          dateBirthDay: dateBirthDay);
      if (ok == true) {
        if (isClosed) return;
        emit(UserInformationSuccess());
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(UserInformationFailure(exception: e));
    }
  }
}
