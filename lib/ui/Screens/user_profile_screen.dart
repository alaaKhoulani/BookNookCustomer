import 'dart:async';
import 'dart:io';
import 'package:book_nook_user/business_logic/cubit/logOut/log_out_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/profile/profile_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/ui/Screens/savedBook/saved_book_cubit.dart';
import 'package:book_nook_user/ui/widgets/Header.dart';
import 'package:book_nook_user/ui/widgets/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:/consts/myColors.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // late Admin admin;
  @override
  void initState() {
    super.initState();
    if (Store.token != null) BlocProvider.of<ProfileCubit>(context).profile();
    // else {
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     _showDialog(context);
    //   });
    // }
    // print("init");
  }

  Widget buildMyButton(var size, String text, IconData icon) {
    return GestureDetector(
      child: Container(
          // height: size.height * .07,
          // width: size.width * .8,
          padding: const EdgeInsets.fromLTRB(10, 2, 20, 0),
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: MyColors.myGreen, width: 1),
            color: MyColors.myWhite,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: MyColors.myGreen,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .12,
              ),
              Text(
                text,
                style: TextStyle(
                  color: MyColors.myGreen,
                ),
              ),
            ],
          )),
      onTap: () {},
    );
  }

  // Future buildShowDialog() {
  //   return Get.defaultDialog(
  //     title: "Let's",
  //     titleStyle: TextStyle(color: MyColors.myGreen),
  //     radius: 15,
  //     barrierDismissible: false,
  //     middleText: "choose image",
  //     middleTextStyle: TextStyle(color: MyColors.myGreen),
  //     actions: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           IconButton(
  //             icon: Icon(Icons.collections_outlined, color: MyColors.myGreen),
  //             onPressed: () {
  //               pickImage(ImageSource.gallery);
  //             },
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.camera_alt_outlined, color: MyColors.myGreen),
  //             onPressed: () {
  //               pickImage(ImageSource.camera);
  //             },
  //           ),
  //         ],
  //       ),
  //     ],
  //     textConfirm: "Done",
  //     confirmTextColor: MyColors.myWhite,
  //     buttonColor: MyColors.myGreen,
  //     onConfirm: () {
  //       Get.back();
  //     },
  //   );
  // }
  // var size, height, width;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // height = size.height;
    // width = size.width;
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    return Store.token != null
        ? _buildProfile()
        : Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You don't have an account"),
                SizedBox(
                  height: 20,
                ),
                Text("You have to login to this application"),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "startHome",
                              arguments: 2);
                        },
                        child: Text(
                          "cancel",
                          style: buttonfont.copyWith(color: MyColors.myBlack),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "startScreen");
                        },
                        child: Text(
                          "log in",
                          style: buttonfont.copyWith(color: MyColors.myPurble),
                        )),
                  ],
                )
              ],
            )),
          );
  }

  Widget _buildProfile() {
    return Scaffold(
        body:
            BlocConsumer<LogOutCubit, LogOutState>(listener: (context, state) {
      if (state is LogOutSubmetting) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return LoadingDialog();
          },
        );
      } else if (state is LogOutSuccessful) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, 'startScreen');
      }
    }, builder: (context, state) {
      if (state is ProfileSubmitting) {
        return _buildLoaddingListWidget();
      } else if (state is ProfileFailure) {
        return Container(
          color: Colors.red,
        );
      } else {
        return SafeArea(
          child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Stack(
                  children: [
                    Container(
                      height: 265,
                      color: MyColors.myGrey,
                    ),
                    // Header(height: screenHeight, width: screenWidth, title: ""),
                    Header(height: screenHeight, width: screenWidth, title: ""),
                    Positioned(
                      right: 170,
                      bottom: 45,
                      child: Text(
                          "${Store.myUser.firstName} ${Store.myUser.lastName}",
                          style: p1.copyWith(color: MyColors.myPurble)),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 5,
                      child: CircleAvatar(
                        child: Text(
                          "${Store.myUser.firstName![0].toUpperCase()}${Store.myUser.lastName![0].toUpperCase()}",
                          style: h1,
                        ),
                        backgroundColor: MyColors.myPurble,
                        radius: 50,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            BlocProvider.of<LogOutCubit>(context).logOut();
                          },
                          icon: Icon(
                            Icons.logout_rounded,
                            color: MyColors.myPurble,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  // margin: EdgeInsets.fromLTRB(10, 20, 30, 20),
                  height: 400,
                  child: GridView(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    physics: AlwaysScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 30,
                        childAspectRatio: 0.7),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      // MyGridTile(
                      //   child: Text(
                      //     "Saved",
                      //     style: p2.copyWith(color: MyColors.myBlack),
                      //     textAlign: TextAlign.center,
                      //   ),
                      //   icon: Icon(
                      //     Icons.favorite_rounded,
                      //     color: MyColors.myPurble,
                      //     size: 35,
                      //   ),
                      //   function: () => Navigator.pushNamed(context, "allBook")
                      //   // Navigator.pushNamed(context, "allBook");
                      //   ,
                      // ),
                      MyGridTile(
                        child: Text(
                          "My orderes",
                          style: p2.copyWith(color: MyColors.myBlack),
                          textAlign: TextAlign.center,
                        ),
                        icon: Icon(
                          Icons.done_outline_rounded,
                          color: MyColors.myPurble,
                          size: 35,
                        ),
                        function: () {},
                      ),
                      MyGridTile(
                        child: Text(
                          "Borrowed",
                          style: p2.copyWith(color: MyColors.myBlack),
                          textAlign: TextAlign.center,
                        ),
                        icon: Icon(
                          Icons.menu_book_rounded,
                          color: MyColors.myPurble,
                          size: 35,
                        ),
                        function: () {
                          Navigator.pushNamed(context, 'borrowedBooksScreen');
                        },
                      ),
                      MyGridTile(
                        child: Text(
                          "Saved books",
                          style: p2.copyWith(color: MyColors.myBlack),
                          textAlign: TextAlign.center,
                        ),
                        icon: Icon(
                          Icons.book_outlined,
                          color: MyColors.myPurble,
                          size: 35,
                        ),
                        function: () async {
                          // final cubit = SavedBookCubit.get(context);
                          // await cubit.getSavedBookApi();
                          Navigator.pushNamed(context, "savedBook");
                        },
                      ),
                      MyGridTile(
                        child: Text(
                          "Settings",
                          style: p2.copyWith(color: MyColors.myBlack),
                          textAlign: TextAlign.center,
                        ),
                        icon: Icon(
                          Icons.settings,
                          color: MyColors.myPurble,
                          size: 35,
                        ),
                        function: () {
                          Navigator.pushNamed(context, "setting");
                        },
                      ),
                      MyGridTile(
                        child: Text(
                          "Address",
                          style: p2.copyWith(color: MyColors.myBlack),
                          textAlign: TextAlign.center,
                        ),
                        icon: Icon(
                          Icons.location_on_rounded,
                          color: MyColors.myPurble,
                          size: 35,
                        ),
                        function: () {
                          Navigator.pushNamed(context, "myAddresses");
                        },
                      ),
                    ],
                  ),
                ),
              ]),
        );
      }
    }));
  }

  // Future<Widget> _showDialog(BuildContext context) async {
  //   return await showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (_) => new AlertDialog(
  //             actions: [
  //               //ToDo:translate
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.pushNamed(context, "startHome", arguments: 2);
  //                   },
  //                   child: Text(
  //                     "cancel",
  //                     style: buttonfont.copyWith(color: MyColors.myBlack),
  //                   )),
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.pushNamed(context, "startScreen");
  //                   },
  //                   child: Text(
  //                     "log in",
  //                     style: buttonfont.copyWith(color: MyColors.myPurble),
  //                   )),
  //             ],
  //             title: Text("You don't have an account"),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //             content: Builder(
  //               builder: (context) {
  //                 return Container(
  //                   height: 75,
  //                   width: 250,
  //                   child: Center(
  //                       child: Text("You have to login to this application")),
  //                 );
  //               },
  //             ),
  //           ));
  // }

  Widget _buildLoaddingListWidget() {
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 90,
                          decoration: BoxDecoration(
                              color: MyColors.myWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Container(
                              height: 10,
                              width: 30,
                              color: MyColors.myWhite,
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 40,
                              color: MyColors.myWhite,
                            ),
                          ),
                        )
                      ],
                    )));
          }),
    );
  }

  Widget MyGridTile(
      {required Widget child,
      required VoidCallback function,
      required Icon icon}) {
    return GestureDetector(
      onTap: function,
      child: GridTile(
        child: Column(
          children: [
            Container(
              height: 90,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 10,
                    // offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                color: MyColors.myGrey,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: icon,
            ),
            SizedBox(
              height: 15,
            ),
            child
          ],
        ),
        //  footer: Container(
        //   height: 30,
        //   decoration: BoxDecoration(
        //     color: MyColors.myBlack.withOpacity(0.5),
        //     borderRadius: BorderRadius.only(
        //       bottomLeft:Radius.circular(20),
        //       bottomRight: Radius.circular(20)
        //     )
        //   ),
        //   child: child,
        //   ),
      ),
    );
  }

  // Widget MyListTile(
  //     {required Icon leadingIcon,
  //     required String lable,
  //     required Icon trailingIcon,
  //     required Function function}) {
  //   return ListTile(
  //     iconColor: MyColors.myPurble,
  //     leading: leadingIcon,
  //     title: Text(lable, style: p1.copyWith(color: MyColors.myBlack)),
  //     trailing: IconButton(
  //       icon: trailingIcon,
  //       onPressed: function.call(),
  //     ),
  //   );
  // }
}
