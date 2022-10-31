import 'dart:convert';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/translate/locale_keys.g.dart';
import 'package:book_nook_user/ui/widgets/Header.dart';
import 'package:book_nook_user/ui/widgets/MyButton.dart';
import 'package:book_nook_user/ui/widgets/inputCard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? validateAddress(var address) {
    String patttern = r'(^[a-zA-Z0-9 ,.-]*$)';
    RegExp regExp = new RegExp(patttern);
    int state = 0;
    if (address.isEmpty || address.length == 0) {
      state = 1;
    } else if (address.length < 10) {
      state = 3;
    } else {
      state = 0;
    }
    if (state == 1) {
      return LocaleKeys.pleaseenteraddress.tr();
    } else if (state == 3) {
      return LocaleKeys.pleaseenterminimum10characters.tr();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: MyColors.myWhite,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 60,
            ),
            Header(
                height: screenHeight,
                width: screenWidth,
                title: LocaleKeys.login.tr()),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: screenWidth * 0.1,
                    ),
                    InputCard(
                      controller: emailController,
                      name: LocaleKeys.email.tr(),
                      vlaidate: validateAddress,
                      width: screenWidth * 0.9,
                    ),
                    InputCard(
                      controller: passwordController,
                      name: LocaleKeys.password.tr(),
                      vlaidate: validateAddress,
                      width: screenWidth * 0.9,
                    ),
                    TextButton(
                      onPressed: (){},
                      child: Text(
                        LocaleKeys.forgetyourpassword.tr(),
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          color: MyColors.myPurble,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyButton(
                        child: Text(
                          LocaleKeys.login.tr(),
                          style: TextStyle(color: MyColors.myWhite),
                        ),
                        fun: () async {
                          Navigator.pushReplacementNamed(
                              context, 'categoryFavotir');
                        },
                        context: context),
                    SizedBox(
                      height: 20,
                    ),
                    toSignUp(context),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget toSignUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.donthaveanaccount.tr(),
          style: TextStyle(
            // decoration: TextDecoration.underline,
            fontSize: 14,
            color: MyColors.myBlack,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, 'SignUp');
          },
          child: Text(
            LocaleKeys.signup.tr(),
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
