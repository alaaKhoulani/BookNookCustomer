import 'package:book_nook_user/business_logic/cubit/setting/seeting_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/data/models/address.dart';
import 'package:book_nook_user/services/validate/validation.dart';
import 'package:book_nook_user/ui/widgets/MyButton.dart';
import 'package:book_nook_user/ui/widgets/inputCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class edatadress extends StatefulWidget {
 final Address address;
  const edatadress({Key? key,required this.address}) : super(key: key);

  @override
  State<edatadress> createState() => _edatadressState();
}

class _edatadressState extends State<edatadress> {
//  late Data _detailes;

  TextEditingController titleConroller = TextEditingController();
  TextEditingController areaConroller = TextEditingController();
  TextEditingController streetConroller = TextEditingController();
  TextEditingController floorConroller = TextEditingController();
  TextEditingController naearConroller = TextEditingController();
  TextEditingController detailsConroller = TextEditingController();
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
                          "Please add yorur library address",
                          style: p1,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        feild(titleConroller, "Title", 53,
                            Validation.validateRegisterFullName, context,titleConroller.value.text),
                        feild(areaConroller, "Area", 53,
                            Validation.validateRegisterFullName, context,areaConroller.value.text),
                        feild(streetConroller, "street", 43,
                            Validation.validateRegisterFullName, context,streetConroller.value.text),
                        feild(floorConroller, "Floor", 50,
                            Validation.validateRegisterFullName, context,floorConroller.value.text),
                        feild(naearConroller, "Near", 51,
                            Validation.validateRegisterFullName, context,naearConroller.value.text),
                        feild(detailsConroller, "Details", 36,
                            Validation.validateRegisterFullName, context,detailsConroller.value.text),
                        MyButton(
                            child: Text("Done",
                                style: buttonfont.copyWith(
                                  color: MyColors.myWhite,
                                )),
                            fun: () {
                              BlocProvider.of<SeetingCubit>(context)
                                  .getEdetAdress(
                                      Title: titleConroller.value.text,
                                      Area: areaConroller.value.text,
                                      street: streetConroller.value.text,
                                      Floor: floorConroller.value.text,
                                      Near: naearConroller.value.text,
                                      Details: detailsConroller.value.text);
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
    FormFieldValidator<String> validate, BuildContext context,String init) {
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
