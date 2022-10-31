import 'dart:developer';

import 'package:book_nook_user/business_logic/cubit/order/order_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/data/models/order.dart';
import 'package:book_nook_user/data/models/pair.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/translate/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyBook extends StatefulWidget {
  final BookInfo book;
  const BuyBook({Key? key, required this.book}) : super(key: key);

  @override
  State<BuyBook> createState() => _orderbookState();
}

class _orderbookState extends State<BuyBook> {
  int count = 1;
  // int price = 200;
  // void _priceincrementcount() {
  //   setState(() {
  //     count++;
  //     price++;
  //   });
  // }

  // void _pricedecrementcount() {
  //   setState(() {
  //     if (count == 0) {
  //       return;
  //     }
  //     price--;
  //     count--;
  //   });
  // }

  void _incrementcount() {
    if (count >= widget.book.quantity!) {
      return;
    }
    setState(() {
      count++;
    });
  }

  void _decrementcount() {
    setState(() {
      if (count <= 1) {
        return;
      }
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _cubit = BlocProvider.of<OrderCubit>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: MyColors.myBlack),
        elevation: 0,
        centerTitle: true,
        title: Text(
          LocaleKeys.orderBook.tr(),
          style: h2.copyWith(color: MyColors.myBlack, fontSize: 18),
        ),
        // iconTheme: ,
        backgroundColor: MyColors.myWhite,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: MyColors.myPurble,
        onPressed: () {
          Orderes orderes =
              Orderes(bookId: widget.book.id, type: "book", quantity: count);
          MyPair _myPair = MyPair(orders: orderes, book: widget.book);
          _cubit.add(_myPair);
          Navigator.pushNamed(context, "shoppingCard", arguments: widget.book);
        },
        label: Center(
          child: Row(children: [
            Text(LocaleKeys.addtoshoppingcart.tr()),
            Icon(Icons.add_shopping_cart),
          ]),
          /*decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              // offset: Offset(0, 0), // changes position of shadow
            ),
          ],

          color: MyColors.myWhite,
          borderRadius: BorderRadius.circular(30),
        ),*/
        ),
      ),
      body: ListView(children: [
        Container(
          // height: 200,
          // width: 200,
          margin: EdgeInsets.only(top: 30, left: 10),
          child: widget.book.image!.isNotEmpty
              ? FadeInImage.assetNetwork(
                  // fit: BoxFit.fill,
                  width: 100,
                  height: 300,
                  image: ("${Store.baseURL}/${widget.book.image!}"),
                  // fit: BoxFit.cover,
                  placeholder: "assets/images/book1.png",
                )
              : Image(image: AssetImage("assets/images/book1.png")),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.book.name}"),
              // Text("${count*widget.book.sellingPrice!}")
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5, left: 20, right: 20),
          margin: EdgeInsets.only(top: 10, left: 60, right: 60),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                // offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            color: MyColors.myWhite,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Text(LocaleKeys.quantity.tr()),
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 5),
                height: 70,
                // width: 50,
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.black),
                  onPressed: () {
                    _incrementcount();
                  },
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  width: 40,
                  child: Text(
                    "$count",
                    style: h2.copyWith(color: MyColors.myPurble),
                  )),
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 10),
                height: 70,
                // width: 50,
                child: IconButton(
                  icon: Icon(Icons.minimize, color: Colors.black),
                  onPressed: () {
                    _decrementcount();
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.totalPrice.tr(),
                style: p1,
              ),
              Text("${count * widget.book.sellingPrice!}",
                  style: h2.copyWith(
                    color: MyColors.myPurble,
                  ))
            ],
          ),
        )
      ]),
    );
  }
}
