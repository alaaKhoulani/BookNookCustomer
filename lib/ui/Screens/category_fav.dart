import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/data/web_services/book_web_services.dart';
import 'package:book_nook_user/translate/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../consts/myColors.dart';

class CategoryFavourite extends StatefulWidget {
  const CategoryFavourite({Key? key}) : super(key: key);

  @override
  State<CategoryFavourite> createState() => _CategoryFavouriteState();
}

class _CategoryFavouriteState extends State<CategoryFavourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: MyColors.myPurble,
        onPressed: () async {
          if (favCat.length != 0)
            await BookWebServices().sendFavoriteCategories(cat: favCat);
          Navigator.pushReplacementNamed(context, 'startHome');
        },
        label: Row(
          children: [Text(LocaleKeys.ok.tr()), Icon(Icons.arrow_right)],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 Text(
                  LocaleKeys.selectatleast3kindsyoulike.tr(),
                  style: const TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 20.0,
                  children: [
                    ChipWidget(
                      lable: chipContainer(LocaleKeys.classics.tr()),
                      id: 1,
                    ),
                    ChipWidget(
                      lable: chipContainer(LocaleKeys.action.tr()),
                      id: 2,
                    ),
                    ChipWidget(
                      id: 3,
                      lable: chipContainer(LocaleKeys.horror.tr()),
                    ),
                    ChipWidget(
                      id: 4,
                      lable: chipContainer(LocaleKeys.crime.tr()),
                    ),
                    ChipWidget(
                      id: 5,
                      lable: chipContainer(LocaleKeys.trueCrime.tr()),
                    ),
                    ChipWidget(
                      id: 6,
                      lable: chipContainer(LocaleKeys.fantasy.tr()),
                    ),
                    ChipWidget(
                      id: 7,
                      lable: chipContainer(LocaleKeys.historicalFiction.tr()),
                    ),
                    ChipWidget(
                      id: 8,
                      lable: chipContainer(LocaleKeys.adventure.tr()),
                    ),
                    ChipWidget(
                      id: 9,
                      lable: chipContainer(LocaleKeys.graphicNovel.tr()),
                    ),
                    ChipWidget(
                      id: 10,
                      lable: chipContainer(LocaleKeys.comicBooks.tr()),
                    ),
                    ChipWidget(
                      id: 11,
                      lable: chipContainer(LocaleKeys.humor.tr()),
                    ),
                    ChipWidget(
                      id: 12,
                      lable: chipContainer(LocaleKeys.mystery.tr()),
                    ),
                    ChipWidget(
                      id: 13,
                      lable: chipContainer(LocaleKeys.romance.tr()),
                    ),
                    ChipWidget(
                      id: 14,
                      lable: chipContainer(LocaleKeys.poetry.tr()),
                    ),
                    ChipWidget(
                      id: 15,
                      lable: chipContainer(LocaleKeys.cookbooks.tr()),
                    ),
                    ChipWidget(
                      id: 16,
                      lable: chipContainer(LocaleKeys.scienceFiction.tr()),
                    ),
                    ChipWidget(
                      id: 17,
                      lable: chipContainer(LocaleKeys.childrensBooks.tr()),
                    ),
                    ChipWidget(
                      id: 18,
                      lable: chipContainer(LocaleKeys.healthFitness.tr()),
                    ),
                    ChipWidget(
                      id: 19,
                      lable: chipContainer(LocaleKeys.biography.tr()),
                    ),
                    ChipWidget(
                      id: 20,
                      lable: chipContainer(LocaleKeys.religion.tr()),
                    ),
                    ChipWidget(
                      id: 21,
                      lable: chipContainer(LocaleKeys.education.tr()),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chipContainer(String lable) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 45,
      padding: const EdgeInsets.all(10),
      child: Text(
        lable,
        style: p1.copyWith(color: MyColors.myBlack),
        textAlign: TextAlign.center,
      ),
    );
  }
}

List<int> favCat = [];

class ChipWidget extends StatefulWidget {
  final lable;
  final int id;
  ChipWidget({Key? key, required this.lable, required this.id})
      : super(key: key);

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FilterChip(
        label: widget.lable,
        backgroundColor: MyColors.myGrey,
        selectedColor: MyColors.myGreen,
        selected: isSelected,
        onSelected: (newvalue) {
          setState(() {
            isSelected = newvalue;
            if (isSelected == true)
              favCat.add(widget.id);
            else
              favCat.remove(widget.id);
            print(favCat.length);
          });
        },
      ),
    );
  }
}
