import 'package:book_nook_user/business_logic/cubit/setting/seeting_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/services/validate/validation.dart';
import 'package:book_nook_user/translate/locale_keys.g.dart';
import 'package:book_nook_user/ui/widgets/MyButton.dart';
import 'package:book_nook_user/ui/widgets/inputCard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatefulWidget {
  // User user;
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _EdetAdminProfileState();
}

class _EdetAdminProfileState extends State<Settings> {
//  late Data _detailes;
  String gender = '';

  String fordate = LocaleKeys.nodateSelected.tr();
  DateTime? _selectedDate;

  TextEditingController firstnameConroller =
      TextEditingController(text: Store.myUser.firstName!);
  TextEditingController middlenameConroller =
      TextEditingController(text: Store.myUser.middleName!);
  TextEditingController lastnametConroller =
      TextEditingController(text: Store.myUser.lastName!);
  // TextEditingController librarynameConroller = TextEditingController();
  TextEditingController phonenumberConroller =
      TextEditingController(text: Store.myUser.phone);

  // String fordate = LocaleKeys.nodateSelected.tr();
  // TimeOfDay _selectedTime = TimeOfDay(hour: 0, minute: 0);
  // TextEditingController stateConroller = TextEditingController(text: );
  // TextEditingController opentimeConroller = TextEditingController();
  // TextEditingController closetimetimeConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: MyColors.myWhite,
      //   title: Text("Add address",style: p1.copyWith(color: MyColors.myBlack,)),
      // ),
      body: BlocBuilder<SeetingCubit, SeetingState>(
        builder: (context, state) {
          return Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 70,
                        ),
                        Text(
                          " Update your informations",
                          style: p1,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        feild(
                            firstnameConroller,
                            "First Name",
                            53,
                            Validation.validateRegisterFullName,
                            context,
                            Store.myUser.firstName!),
                        feild(
                            middlenameConroller,
                            "Middle Name",
                            43,
                            Validation.validateRegisterFullName,
                            context,
                            Store.myUser.middleName!),
                        feild(
                            lastnametConroller,
                            "Last Name",
                            53,
                            Validation.validateRegisterFullName,
                            context,
                            Store.myUser.lastName!),
                        // feild(librarynameConroller, "Library Name", 33,
                        //     Validation.validateRegisterFullName, context,),
                        feild(
                            phonenumberConroller,
                            "phone Namber",
                            29,
                            Validation.validateRegisterFullName,
                            context,
                            Store.myUser.phone!),

                        // feild(stateConroller, "Birth", 90,
                        //     Validation.validateRegisterFullName, context,),
                        // feild(opentimeConroller, "open Time", 53,
                        //     Validation.validateRegisterFullName, context),
                        // feild(closetimetimeConroller, "close Time", 53,
                        //     Validation.validateRegisterFullName, context),

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
                                Text("male"), //ToDo:translate
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
                                Text("female"), //ToDo:translate
                              ],
                            )
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "changPassword");
                            },
                            child: Text("Change password ",//ToDo translate
                                style: p1.copyWith(
                                  color: MyColors.myPurble,
                                  decoration: TextDecoration.underline,
                                ))),
                        MyButton(
                            child: Text("Done",
                                style: buttonfont.copyWith(
                                  color: MyColors.myWhite,
                                )),
                            fun: () {
                              BlocProvider.of<SeetingCubit>(context)
                                  .getEdetuserprofile(
                                      first_name: firstnameConroller.value.text,
                                      middle_name:
                                          middlenameConroller.value.text,
                                      last_name: lastnametConroller.value.text,
                                      gender: gender,
                                      phone_number:
                                          phonenumberConroller.value.text,
                                      birth_day: fordate);
                              // .getEdetadminprofile(
                              //    { first_name: firstnameConroller.value.text,
                              //     Area: middlenameConroller.value.text,
                              //     street: lastnametConroller.value.text,
                              //     Floor: librarynameConroller.value.text,
                              //     Near: phonenumberConroller.value.text,
                              //     Details: stateConroller.value.text
                              //      opentime: opentimeConroller.value.text
                              //       Details: closetimetimeConroller.value.text}

                              // );
                            },
                            context: context),
                      ])),
            ),
          );
        },
      ),
    );
  }
}

Widget feild(TextEditingController controller, String name, double spaceWidth,
    FormFieldValidator<String> validate, BuildContext context, String init) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("$name:"),
      SizedBox(
        width: spaceWidth,
      ),
      Expanded(
        child: Row(
          children: [
            Expanded(
              child: InputCard(
                init: init,
                name: "$name",
                controller: controller,
                vlaidate: validate,
              ),
            ),
            name == "Authors" || name == "Category"
                ? IconButton(onPressed: () {}, icon: Icon(Icons.send_rounded))
                : Container()
          ],
        ),
      ),
    ],
  );
}
