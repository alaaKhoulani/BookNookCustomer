import 'dart:convert';
import 'dart:io';
import 'package:book_nook_user/business_logic/cubit/register_cubit/register_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/services/auth/facebook_auth.dart';
import 'package:book_nook_user/services/auth/google_auth.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/translate/locale_keys.g.dart';
import 'package:book_nook_user/ui/widgets/MyButton.dart';
import 'package:book_nook_user/ui/widgets/loaading_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../consts/myColors.dart';
import 'package:http/http.dart' as http;

class StartScreen extends StatefulWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? user = await GoogleSignInApi.login();
    if (user != null)
      BlocProvider.of<RegisterCubit>(context).ProviderlogIn(
          email: user.email, provider_id: user.id, fcmToken: "fcmToken");

    GoogleSignInApi.logOut();
    print(user);
  }

  signInWithFacebook() async {
    var user = await FacebookSignInApi.login();
    print(user);
  }

  // info() async {
  //   try {
  //     final token = Store.token;
  //     var response =
  //         await http.post(Uri.parse("${Store.baseURL}/api/info"), headers: {
  //       "Accept": "application/json",
  //     }, body: {
  //       "first_name": "firstName",
  //       "middle_name": "middleName",
  //       "last_name": "lastName",
  //       "library_name": "libraryName",
  //       "phon": "phonNumber",
  //       "acces token": "Bearer $token",
  //     });
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       return (json.decode(response.body) as Map<String, dynamic>)['data'];
  //     } else if (response.statusCode == 400) {
  //       throw Exception(
  //           (json.decode(response.body) as Map<String, dynamic>)['message']);
  //     } else {
  //       throw Exception("Something went wrong");
  //     }
  //   } on SocketException {
  //     throw Exception("No internet connection");
  //   }
  // }

  // signInWithFaceook() async {
  //   print("=====face======");
  //   var user = await FacebookSignInApi.login();
  //   print(user);
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: MyColors.myWhite,
        body: BlocConsumer<RegisterCubit, RegisterState>(
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
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 60,
                ),
                Container(
                    //margin: EdgeInsets.only(top: 50),
                    height: screenHeight * 0.25,
                    child:
                        Image(image: AssetImage("assets/images/book-nook.png"))
                    //ShortWaveContainer(),
                    ),
                Text(
                  "Book Nook",
                  style: h1.copyWith(color: MyColors.myPurble),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 60, 30, 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      MyButton(
                          child: Text(
                            "Sign up",
                            style: TextStyle(color: MyColors.myWhite),
                          ),
                          fun: () {
                            Store.state = 1;
                            Navigator.pushNamed(context, 'SignUp');
                          },
                          context: context),
                      SizedBox(
                        height: 20,
                      ),
                      MyButton(
                          child: Text(
                            "Log in",
                            style: TextStyle(color: MyColors.myWhite),
                          ),
                          fun: () => Navigator.pushNamed(context, 'login'),
                          context: context),
                      SizedBox(
                        height: 20,
                      ),
                      MyButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Sign up with Google",
                                style: TextStyle(color: MyColors.myWhite),
                              ),
                              Image.asset(
                                "assets/images/google.png",
                                width: 20,
                              ),
                            ],
                          ),
                          fun: () async {
                            Store.state = 2;
                            await signInWithGoogle(context);
                            // Navigator.pushNamed(context, 'adminInformation');
                          },
                          context: context),
                      SizedBox(
                        height: 20,
                      ),
                      MyButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Sign up with Facebook",
                                style: TextStyle(color: MyColors.myWhite),
                              ),
                              Image.asset(
                                "assets/images/facebook.png",
                                width: 20,
                              ),
                            ],
                          ),
                          fun: () async {
                            Store.state = 3;
                            print(
                                "=====================================Facebook");
                            await signInWithFacebook();
                            // Navigator.pushNamed(context, 'adminInformation');
                          },
                          context: context),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Container(
                      //       // width: 150,
                      //       child: InkWell(
                      //         onTap: () {},
                      //         child: CircleAvatar(
                      //           radius: 20,
                      //           backgroundColor: MyColors.myWhite,
                      //           backgroundImage:
                      //               AssetImage("assets/images/google.png"),
                      //         ),
                      //       ),
                      //     ),
                      //     // Container(
                      //     // width: 150,
                      //     //   child: InkWell(
                      //     //     onTap: () {
                      //     //       // signInWithFaceook();
                      //     //     },
                      //     //     child: CircleAvatar(
                      //     //       radius: 20,
                      //     //       backgroundImage:
                      //     //           AssetImage("assets/images/facebook.png"),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
