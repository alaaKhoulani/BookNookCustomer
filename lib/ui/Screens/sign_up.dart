import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:book_nook_user/business_logic/cubit/register_cubit/register_cubit.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/data/repository/user_repository.dart';
import 'package:book_nook_user/data/web_services/user_web_services.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/services/validate/validation.dart';
import 'package:book_nook_user/ui/widgets/Header.dart';
import 'package:book_nook_user/ui/widgets/MyButton.dart';
import 'package:book_nook_user/ui/widgets/inputCard.dart';
import 'package:book_nook_user/ui/widgets/loaading_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../consts/constant.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController libraryNameConmtroller = TextEditingController();
  TextEditingController libraryAddressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    // final cubit = BlocProvider.of<RegisterCubit>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: MyColors.myWhite,
        body: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
             if (state is RegisterSubmitting) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return LoadingDialog();
              },
            );
          } else if (state is RegisterSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, 'adminInformation');
          } else if (state is RegisterFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text((state.exception.toString() + '.'))));
          } 
          },
          child: SafeArea(
            child: Column(
              children: [
                Header(height: height, width: width, title: "SignUp"),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Form(
                            child: Column(
                              children: [
                                InputCard(
                                    name: "Your Email",
                                    controller: emailController,
                                    vlaidate: Validation.validateEmail),
                                InputCard(
                                    name: "Password",
                                    controller: passwordController,
                                    vlaidate:
                                        Validation.validateRegisterPassword),
                                InputCard(
                                    name: "Confirm Password",
                                    controller: confirmPasswordController,
                                    vlaidate:
                                        Validation.validateRegisterPassword),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          MyButton(
                              child: Text(
                                "Register",
                                style: TextStyle(color: MyColors.myWhite),
                              ),
                              fun: () async {
                                if (emailController.value.text.isNotEmpty &&
                                    emailController.value.text != null &&
                                    passwordController.value.text.isNotEmpty &&
                                    passwordController.value.text != null &&
                                    confirmPasswordController
                                        .value.text.isNotEmpty &&
                                    confirmPasswordController.value.text !=
                                        null) {
                                  await UserRepository(UserWebServices())
                                      .register(
                                          email: emailController.value.text,
                                          password:
                                              passwordController.value.text,
                                          confirmPassword:
                                              confirmPasswordController
                                                  .value.text,
                                          fcmToken: Store.fcmToken!);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              ('All fields are requird.'))));
                                }
                              },
                              context: context),
                          toLogin(context),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget toLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have any account ? ",
          style: TextStyle(
            color: MyColors.myBlack,
            // decoration: TextDecoration.underline,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "SignUp");
          },
          child: Text(
            "log in",
            style: TextStyle(
              color: MyColors.myPurble,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
