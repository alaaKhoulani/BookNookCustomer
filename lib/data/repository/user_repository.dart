import 'dart:async';
import 'dart:io';

import 'package:book_nook_user/data/models/user.dart';
import 'package:book_nook_user/data/web_services/user_web_services.dart';

class UserRepository {
  final UserWebServices _userrWebServices;
  UserRepository(this._userrWebServices);

  Future<String> register(
      {required String email,
      required String password,
      required String confirmPassword,
      required String fcmToken}) async {
    final admin = await _userrWebServices.register(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        fcmToken: fcmToken);
    return admin['access_token'];
  }

  //-----------------------verify---------------------------
  Future<bool> isVerify({
    required String token,
  }) async {
    var response = await _userrWebServices.isVerify(token: token);
    return response["verified"] == 1 ? true : false;
  }

//--------------------profile-------------------------------------------
  Future<User> profle() async {
    var response = await _userrWebServices.profle();
    // print(Admin().fromJson1(response).libraryName);
    return User().fromJson(response);
  }

  //--------------------information-------------------------
  Future<bool> submitInformation(
      {required String firstName,
      required String middleName,
      required String lastyName,
      required String phonNumber,
      required String gender,
      required String dateBirthDay}) async {
    return await _userrWebServices.submitInformation(
        firstName: firstName,
        middleName: middleName,
        lastyName: lastyName,
        phonNumber: phonNumber,
        gender: gender,
        dateBirthDay: dateBirthDay);
  }

  //-------------- add address-------------------------
  Future<bool> addAddress(
      {required String title,
      required String area,
      required String street,
      required String floor,
      required String near,
      String details = ''}) async {
    return await _userrWebServices.addAddress(
        area: area,
        title: title,
        street: street,
        floor: floor,
        near: near,
        details: details);
  }

  //------------------ log out---------------------------------
  Future<bool> logOut() async {
    return await _userrWebServices.logOut();
  }

  //------------------log in-----------------
  Future<String> logIn({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    var response = await _userrWebServices.logIn(
        email: email, password: password, fcmToken: fcmToken);
    return response['access_token'];
  }

  //------------------provider log in-----------------
  Future<String> ProviderLogIn({
    required String email,
    required String provider_id,
    required String fcmToken,
  }) async {
    var response = await _userrWebServices.ProviderlogIn(
        email: email, provider_id: provider_id, fcmToken: fcmToken);
    return response['token'];
  }
}
