import 'package:book_nook_user/business_logic/cubit/home_page/home_page_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/ui/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/../consts/myColors.dart';

class CategoriesRow extends StatefulWidget {
  const CategoriesRow();

  @override
  State<CategoriesRow> createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  int selectedIndex = 0;
  PageController? _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _cubit=BlocProvider.of<HomePageCubit>(context);
    _pageController = PageController(initialPage: _cubit.selectedCategory, viewportFraction: 0.4);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CatItem(index: index);
            }));
  }
}

class CatItem extends StatelessWidget {
  const CatItem({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    var _cubit = BlocProvider.of<HomePageCubit>(context);
    return GestureDetector(
      onTap: () async {
        _cubit.selectedCategory = index;
        if (index == 0) {
          
        } else if (index == 1) {

        } else {
          await _cubit.getBooksInCategory(id: _cubit.selectedCategory-1);
        }
      },
      child: Container(
        padding: EdgeInsets.zero,
        width: 120,
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: index == _cubit.selectedCategory
                ? MyColors.myPurble
                : MyColors.myWhite,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: index == 2
                    ? MyColors.myPurble
                    : MyColors.myBlack.withAlpha(75))),
        child: Text(
          "${categories[index].name}",
          style: p3.copyWith(
            // fontSize: 15,
            color: index == _cubit.selectedCategory
                ? MyColors.myWhite
                : MyColors.myBlack,
          ),
        ),
      ),
    );
  }
}
