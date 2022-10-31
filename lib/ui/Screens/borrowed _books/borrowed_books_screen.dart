import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/ui/Screens/borrowed%20_books/model.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../consts/myColors.dart';
import '../../../translate/locale_keys.g.dart';
import 'borrowed_books_cubit.dart';
import 'borrowed_books_state.dart';

class BorrowedBooksScreen extends StatefulWidget {
  const BorrowedBooksScreen({Key? key, this.control}) : super(key: key);
  final control;
  @override
  State<BorrowedBooksScreen> createState() =>
      _BorrowedBooksScreenState(control);
}

class _BorrowedBooksScreenState extends State<BorrowedBooksScreen> {
  _BorrowedBooksScreenState(this.control);
  final control;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cubit = BorrowedBooksCubit.get(context);
    cubit.getData();
  }

  List<Borrowed> borrowed = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<BorrowedBooksCubit, BorrowedBooksStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BorrowedBooksInitial) {
            return _buildLoaddingListWidget();
          } else {
            final cubit = BorrowedBooksCubit.get(context);
            // this.borrowed=(state as
            this.borrowed = cubit.BooksData;

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                title: Text(
                  LocaleKeys.borrowedBook.tr(),
                  style: p1.copyWith(color: MyColors.myBlack),
                ),
                backgroundColor: MyColors.myWhite,
              ),
              body: buildSearchstart(this.borrowed, cubit, size, 1),
              //   floatingActionButton: FloatingActionButton(
              //       onPressed: () {
              //         cubit.getBorrowBookApi();
              //       },
              //       child: Icon(Icons.add)),
              //
            );
          }
        });
  }

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

  Widget buildSearchField(cubit) {
    return TextField(
      style: TextStyle(
        color: MyColors.myWhite,
      ),
      cursorColor: MyColors.myWhite,
      decoration: InputDecoration(
          labelStyle: TextStyle(
            color: MyColors.myWhite,
          ),
          hintText: LocaleKeys.search.tr(),
          hintStyle: TextStyle(
            color: MyColors.myWhite,
          ),

          // hintStyle: p2.copyWith(color: MyColors.myBlack),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none),
      autofocus: false,
      onChanged: (title) {
        cubit.getResult(title);
      },
    );
  }

  Widget buildBookItem(Borrowed item, size, cubit) {
    return Container(
      height: size.height * .2,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.fromLTRB(2, 15, 2, 0),
      // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: GridTile(
        child: Container(),
        header: GridTileBar(
          leading: GestureDetector(
            child: item.book!.image!.isEmpty
                ? Image.asset("assets/images/book1.png")
                : FadeInImage.assetNetwork(
                    fit: BoxFit.fill,
                    image: ("${Store.baseURL}/${item.book!.image}"),
                    // fit: BoxFit.cover,
                    placeholder: "assets/images/book1.png",
                  ),
            onTap: () {
              print("Go to book details page");
            },
          ),
          trailing: SleekCircularSlider(
            appearance: CircularSliderAppearance(
              size: 50,
              customWidths: CustomSliderWidths(progressBarWidth: 3),
              customColors: item.remainingdays == 0
                  ? CustomSliderColors(
                      dotColor: Colors.grey,
                      trackColor: Colors.grey,
                      progressBarColor: Colors.grey,
                    )
                  : CustomSliderColors(),
              infoProperties: InfoProperties(
                topLabelText: "${item.remainingdays}",
                topLabelStyle:
                    TextStyle(fontSize: 10, color: MyColors.myPurble),
                mainLabelStyle:
                    TextStyle(fontSize: 0.1, color: MyColors.myPurble),
              ),
            ),
            min: 0,
            max: 30,
            initialValue: (item.remainingdays!).toDouble(),
          ),
          title: Text(item.book!.name.toString(),
              style: TextStyle(color: MyColors.myPurble)),
          // subtitle:
          //     Text(book['date'], style: TextStyle(color: MyColors.myPurble)),
        ),
        footer: GridTileBar(
          // backgroundColor: Colors.white.withAlpha(200),
          title: Text(""),
          leading: TextButton(
            child: Text("libraryName",
                style: TextStyle(color: MyColors.myPurble)),
            onPressed: () {
              print("go to library page");
            },
          ),
          // trailing: Row(
          //   children: [
          //     Text(LocaleKeys.returned.tr(),
          //         style: TextStyle(
          //             color: item.remainingdays == 35
          //                 ? Colors.green
          //                 : item.remainingdays == 30
          //                     ? Colors.red
          //                     : Colors.red)),
          //     IconButton(
          //       icon: item.remainingdays == 35
          //           ? Icon(Icons.check_circle_outline_rounded,
          //               color: Colors.green)
          //           : item.remainingdays == 30
          //               ? Icon(Icons.cancel_outlined, color: Colors.red)
          //               : Icon(Icons.cancel_outlined, color: Colors.red),
          //       // color: Theme.of(context).primaryColor,
          //       onPressed: () {},
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  Widget buildSearchstart(items, cubit, size, control) {
    return items.length == 0
        ? Container(
            // child: Image.asset("assets/images/notfound.gif",
            //     height: size.height, width: size.width)
            )
        : Container(
            child: ListView.builder(
            itemBuilder: (context, index) => control == 1
                ? buildBookItem(items[index], size, cubit)
                : buildPurchasedBook(items[index], cubit),
            itemCount: borrowed.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
          ));
  }

  Widget buildPurchasedBook(book, cubit) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            print("Go to book details page");
          },
          child: ListTile(
            // dense: true,
            leading: Image.asset(book['photo']),
            title:
                Text(book['title'], style: TextStyle(color: MyColors.myPurble)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book['date'],
                    style: TextStyle(color: MyColors.myPurble, fontSize: 10)),
                Text(book['lib name'],
                    style: TextStyle(color: MyColors.myPurble, fontSize: 10)),
              ],
            ),
            trailing: TextButton(
                child: Text("${book['price']}",
                    style: TextStyle(color: MyColors.myPurble)),
                onPressed: () {}),
          ),
        ));
  }
}
