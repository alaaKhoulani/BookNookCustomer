import 'package:book_nook_user/business_logic/cubit/home_page/home_page_cubit.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/ui/Screens/HomePage.dart';
import 'package:book_nook_user/ui/Screens/allLibrary/screen.dart';
import 'package:book_nook_user/ui/Screens/all_book.dart';
import 'package:book_nook_user/ui/Screens/myorders.dart';
import 'package:book_nook_user/ui/Screens/search_user/search_screen.dart';
import 'package:book_nook_user/ui/Screens/user_profile_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartHome extends StatefulWidget {
  final int index;

  StartHome({super.key, required this.index});
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<StartHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomePageCubit>(context).selectedScreen = widget.index;
    //  BlocProvider.of<HomePageCubit>(context)
    //       .getAllBooks()
    //       .then((value) => this.books = value);
  }

  // int index = 2;
  final screens = [
    // MyOrder(),
    AllLibrary(),
    HomePage(),
    SearchHomeScreenUser(),
    UserProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var _cubit = BlocProvider.of<HomePageCubit>(context);
    final items = <Widget>[
      Icon(Icons.home, size: 25),
      Icon(Icons.person, size: 25),
      Icon(Icons.favorite, size: 30),
      // Icon(Icons.search, size 25),
    ];
    return Scaffold(
      body: screens[_cubit.selectedScreen],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: MyColors.myGreen,
        selectedIndex: _cubit.selectedScreen,
        onItemSelected: (index) {
          // _cubit.changePage(index);
          setState(() {
            _cubit.selectedScreen = index;
          });
        },
        items: <BottomNavyBarItem>[
          // BottomNavyBarItem(
          //   icon: Icon(Icons.my_library_books_rounded),
          //   title: Text('My Orders'),
          //   activeColor: MyColors.myPurble,
          //   inactiveColor: MyColors.myPurble,
          // ),
          BottomNavyBarItem(
            icon: Icon(Icons.store_mall_directory_rounded),
            title: Text('Libraries'),
            activeColor: MyColors.myPurble,
            inactiveColor: MyColors.myPurble,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.home_rounded),
            title: Text('Home Page'),
            activeColor: MyColors.myPurble,
            inactiveColor: MyColors.myPurble,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search_rounded),
            title: Text('Search'),
            activeColor: MyColors.myPurble,
            inactiveColor: MyColors.myPurble,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person_rounded),
            title: Text('Profile'),
            activeColor: MyColors.myPurble,
            inactiveColor: MyColors.myPurble,
          ),
        ],
      ),

    );
  }
}
