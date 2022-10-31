import 'dart:convert';
import 'dart:io';
import 'package:book_nook_user/data/models/user.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserWebServices {
  //-------------------------------- register------------------------------------
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String fcmToken,
  }) async {
    try {
      print("======================register start==============");
      var response =
          await http.post(Uri.parse("${Store.baseURL}/api/register"), headers: {
        "Accept": "application/json",
      }, body: {
        "email": email,
        "password": password,
        "password confirmation": confirmPassword,
        "fcm_token": fcmToken,
        "role_id": '2'
      });


      print(response.body);
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      // String dd = responseBody['token'];
      // pref.set('token',dd);



      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print(response.body);
        return (json.decode(response.body) as Map<String, dynamic>)['data'];
      } else if (response.statusCode == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    }
  }
  //-------------------------------------Logn in ---------------------------------------------

  Future<Map<String, dynamic>> logIn({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      print("======================login start==============");

      var response =
          await http.post(Uri.parse("${Store.baseURL}/api/login"), headers: {
        "Accept": "application/json",
      }, body: {
        "email": email,
        "password": password,
        "fcm_token": fcmToken,
        "role_id": '2',
      });
      print(response.body);
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print(response.body);
        return (json.decode(response.body) as Map<String, dynamic>)['data'];
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } on Exception {
      throw Exception("Some Thing went wrong");
    }
  }

  Future<Map<String, dynamic>> ProviderlogIn({
    required String email,
    required String provider_id,
    required String fcmToken,
  }) async {
    try {
      print("======================provider login start==============");

      var response = await http.post(
          Uri.parse("${Store.baseURL}/api/provider/loginOrRegister"),
          headers: {
            "Accept": "application/json",
          },
          body: {
            "email": email,
            "provider_id": provider_id,
            "fcm_token": "fcmToken",
            "role_id": '2',
          });
      print(response.body);
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print(response.statusCode);
        print(response.body);
        return (json.decode(response.body) as Map<String, dynamic>)['data'];
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } on Exception {
      throw Exception("Some Thing went wrong");
    }
  }

  //-------------------------------- register information------------------------------------

  Future<bool> submitInformation(
      {required String firstName,
      required String middleName,
      required String lastyName,
      required String phonNumber,
      required String gender,
      required String dateBirthDay}) async {
    try {
      print("web");
      var response = await http.post(
          Uri.parse("${Store.baseURL}/api/information/customer"),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${Store.token}'
          },
          body: {
            "first_name": firstName,
            "middle_name": middleName,
            "last_name": lastyName,
            "phone": phonNumber,
            "gender": gender,
            "birth_day": "1-1-2002"
          });
      print(response.body);
      var responseBody = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print("logIn==================");
        print(response.body);
        return true;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    }
  }
  //---------------------------------

  Future<Map<String, dynamic>> isVerify({required String token}) async {
    var response =
        await http.get(Uri.parse("${Store.baseURL}/api/is_verified"), headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    });
    print("very");
    var responseBody = json.decode(response.body) as Map<String, dynamic>;

    print(response.body);
    if (response.statusCode == 200) {
      return (json.decode(response.body) as Map<String, dynamic>)['data'];
    } else if (response.statusCode == 400) {
      throw Exception(
          (json.decode(response.body) as Map<String, dynamic>)['message']);
    } else {
      throw Exception("Something went wrong");
    }
  }

//-------------------------------------profile---------------------------------
  Future<Map<String, dynamic>> profle() async {
    try {
      var response = await http.get(Uri.parse("${Store.baseURL}/api/profile"),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${Store.token}'
          });
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      // print("profile");
      // print(responseBody);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        // print("profile done");
        // print(response.body);
        return responseBody["data"];
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    }
  }

  //------------------------- add address ---------------------
  Future<bool> addAddress(
      {required String title,
      required String area,
      required String street,
      required String floor,
      required String near,
      String details = ''}) async {
    try {
      var response =
          await http.post(Uri.parse("${Store.baseURL}/api/address/"), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer ${Store.token}'
      }, body: {
        "title": title,
        "area": area,
        "street": street,
        "floor": floor,
        "near": near,
        details: details == '' ? "null" : details
      });
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print("address");
      print(responseBody);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print("okkk address");
        print(response.body);
        return true;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on Exception {
      throw Exception("Something went wrong");
    }
  }

  //------------------ log out---------------------------------
  Future<bool> logOut() async {
    try {
      var response = await http.post(Uri.parse("${Store.baseURL}/api/logout"),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${Store.token}'
          },
          body: {
            "fcm_token": Store.fcmToken
          });
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print("address");
      print(responseBody);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print("okkk address");
        print(response.body);
        return true;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on Exception {
      throw Exception("Something went wrong");
    }
  }
}
