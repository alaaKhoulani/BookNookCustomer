import 'package:flutter/material.dart';

import '/../consts/constant.dart';
import '/../consts/myColors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: MyColors.myWhite,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,

          children: [
            Container(
              color: MyColors.myPurble,
              padding: EdgeInsets.fromLTRB(10, 60, 10, 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: MyColors.myPurble,
                    backgroundImage: AssetImage("assets/images/library.jpg"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Library Name",
                    style: h2.copyWith(color: MyColors.myWhite),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, "profile");
              },
              title: Text("My Account",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.home_work,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("Current Offers",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.home_work,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("Earning",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.attach_money_rounded,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("Sold Books",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.done_outline_rounded,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("Borrowed Books",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.menu_book_rounded,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("statistics",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.bar_chart_rounded,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("My Orders",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.menu_book_rounded,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("about us",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.menu_book_rounded,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("Log Out",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.logout_outlined,
                color: MyColors.myPurble2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
