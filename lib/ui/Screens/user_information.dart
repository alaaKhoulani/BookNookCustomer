import 'dart:convert';
import 'dart:io';
import 'package:book_nook_user/business_logic/cubit/user_information/user_information_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/translate/locale_keys.g.dart';
import 'package:book_nook_user/services/validate/validation.dart';
import 'package:book_nook_user/ui/widgets/Header.dart';
import 'package:book_nook_user/ui/widgets/MyButton.dart';
import 'package:book_nook_user/ui/widgets/inputCard.dart';
import 'package:book_nook_user/ui/widgets/loaading_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import '../../../consts/myColors.dart';
import '../../services/storage/store.dart';

class UserInformation extends StatefulWidget {
  UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _AdminInformationState();
}

class _AdminInformationState extends State<UserInformation> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController libraryNameController = TextEditingController();
  TimeOfDay? start, end;
  String fordate = LocaleKeys.nodateSelected.tr();

  TimeOfDay _selectedTime = TimeOfDay(hour: 0, minute: 0);
  
  String gender = "";

  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    DateTime? _selectedDate;
    var screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    return BlocListener<UserInformationCubit, UserInformationState>(
      listener: (context, state) {
        if (state is UserInformationSubmitting) {
          print("Doneeeeeeeeeeeeeeeeeeeeeeeeeeee");
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return LoadingDialog();
            },
          );
        } else if (state is UserInformationSuccess) {
          print("Doneeeeeeeeeeeeeeeeeeeeeeeeeeee");
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'categoryFavotir');
        } else if (state is UserInformationFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text((state.exception.toString() + '.'))));
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: FloatingActionButton.extended(
          //   backgroundColor: MyColors.myPurble,
          //   onPressed: ,
          //   label:
          // ),
          backgroundColor: MyColors.myWhite,
          body: SafeArea(
            child: Column(
              children: [
                Header(height: height, width: width, title: ""),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Text(LocaleKeys.yourInformation.tr(),
                              style: h2.copyWith(
                                color: MyColors.myBlack,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          InputCard(
                            name: LocaleKeys.firstname.tr(),
                            controller: firstNameController,
                            vlaidate: Validation.validateRegisterFullName,
                          ),
                          InputCard(
                            name: LocaleKeys.middlename.tr(),
                            controller: middleNameController,
                            vlaidate: Validation.validateRegisterFullName,
                          ),
                          InputCard(
                            name: LocaleKeys.lastname.tr(),
                            controller: lastNameController,
                            vlaidate: Validation.validateRegisterFullName,
                          ),
                          InputCard(
                            name: LocaleKeys.yourphonenumber.tr(),
                            controller: phoneController,
                            vlaidate: Validation.validateRegisterPhoneNumber,
                          ),
                          Row(children: [
                            Container(
                              padding: const EdgeInsets.all(30),
                              child: Text(
                                fordate,
                                style: p1,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.date_range_rounded),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime.now())
                                    .then((pickedDate) {
                                  print("date");
                                  print(pickedDate);
                                  if (pickedDate == null) {
                                    return;
                                  }
                                  setState(() {
                                    fordate = pickedDate.year.toString() +
                                        '-' +
                                        pickedDate.month.toString() +
                                        '-' +
                                        pickedDate.day.toString();
                                    _selectedDate = pickedDate;
                                  });
                                });
                              },
                            )
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: "male",
                                      groupValue: gender,
                                      onChanged: (x) {
                                        setState(() {
                                          gender = x.toString();
                                        });
                                      }),
                                  Text("LocaleKeys.male.tr()"),//ToDo:translate
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: "female",
                                      groupValue: gender,
                                      onChanged: (x) {
                                        setState(() {
                                          gender = x.toString();
                                        });
                                      }),
                                  Text("LocaleKeys.m.tr()"),//ToDo:translate
                                ],
                              )
                            ],
                          ),
                          MyButton(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                width: screenWidth * 0.5,
                                child: Center(
                                  child: Text(
                                    LocaleKeys.continuef.tr(),
                                    style: TextStyle(color: MyColors.myWhite),
                                  ),
                                ),
                              ),
                              fun: () async {
                                print("fun");
                                if (firstNameController.value.text.isNotEmpty &&
                                    firstNameController.value.text != null &&
                                    middleNameController
                                        .value.text.isNotEmpty &&
                                    middleNameController.value.text != null &&
                                    lastNameController.value.text.isNotEmpty &&
                                    lastNameController.value.text != null &&
                                    phoneController.value.text.isNotEmpty &&
                                    phoneController.value.text != null &&
                                    gender.isNotEmpty &&
                                    gender != "") {
                                  print("iffffffffff");
                                  await BlocProvider.of<UserInformationCubit>(
                                          context)
                                      .submitInformation(
                                          firstName: firstNameController.value.text
                                              .toString(),
                                          middleName: middleNameController
                                              .value.text
                                              .toString(),
                                          lastyName: lastNameController
                                              .value.text
                                              .toString(),
                                          phonNumber: phoneController.value.text
                                              .toString(),
                                          gender: gender,
                                          dateBirthDay: "");
                                }
                              },
                              context: context)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


  ///..... add more methods/properties for your convenience

