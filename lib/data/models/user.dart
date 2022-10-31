import 'dart:io';
import 'package:flutter/material.dart';

class User {
  int? userId;
  int? roleId;
  String? email;
  int? isVerified;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? phone;
  String? birthDay;
  String? createdAt;
  String? updatedAt;

  User(
      {this.userId,
      this.roleId,
      this.email,
      this.isVerified,
      this.firstName,
      this.middleName,
      this.lastName,
      this.gender,
      this.phone,
      this.birthDay,
      this.createdAt,
      this.updatedAt});

  User fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      roleId: json['role_id'],
      email: json['email'],
      isVerified: json['is_verified'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      phone: json['phone'],
      birthDay: json['birth_day'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

 

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['email'] = this.email;
    data['is_verified'] = this.isVerified;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['birth_day'] = this.birthDay;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
