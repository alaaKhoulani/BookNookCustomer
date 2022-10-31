import 'package:book_nook_user/business_logic/cubit/order/order_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/data/models/offers.dart';
import 'package:book_nook_user/data/models/order.dart';
import 'package:book_nook_user/data/models/pair.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../consts/myColors.dart';
import '../../translate/locale_keys.g.dart';

class ShoppingCard extends StatelessWidget {
  // final MyPair myPair;

  ShoppingCard({
    super.key, //required this.myPair,
  });

  @override
  Widget build(BuildContext context) {
    var _cubit = BlocProvider.of<OrderCubit>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyColors.myPurble, //change your color here
        ),
        centerTitle: true,
        title: Text(LocaleKeys.middlename.tr(),//ToDo:translate
            style: p1.copyWith(
              color: MyColors.myPurble,
            )),
        elevation: 0,
        backgroundColor: MyColors.myWhite,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Container(
            width: 70,
            alignment: Alignment.center,
            child: Text(
              LocaleKeys.send.tr(),
              style: buttonfont,
            )),
        backgroundColor: MyColors.myPurble,
        onPressed: () {
          BlocProvider.of<OrderCubit>(context).postOrder();
        },
      ),
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                add(context),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: _cubit.myPair.length,
                  itemBuilder: (context, index) {
                    return _myCard(_cubit.myPair[index], context);
                  },
                ),
              ],
            ),
          ));
        },
      ),
    );
  }

  Widget add(BuildContext context) {
    var _cubit = BlocProvider.of<OrderCubit>(context);
    return TextButton(
      onPressed: () {
        if (_cubit.myPair[0].book != null) {
          print("nav");
          print(_cubit.myPair.length);
          print(_cubit.myPair[0].book!.library);
          Navigator.pushNamed(context, "libraryScreen",
              arguments: _cubit.myPair[0].book!.library);
        } else
          Navigator.pushNamed(context, "libraryScreen",
              arguments: _cubit.myPair[0].offer!.libraryId);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: MyColors.myPurble,
              )),
          // SizedBox(width: 20,),
          Text(
            LocaleKeys.addanorder.tr(),
            style: p1.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _myCard(MyPair myPair, BuildContext context) {
    var _cubit = BlocProvider.of<OrderCubit>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Card(
        color: MyColors.myGrey,
        child: ListTile(
          title: myPair.orders.type == "offer"
              ? Text(myPair.offer!.title.toString())
              : Text(myPair.book!.name.toString()),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              myPair.offer != null
                  ? Text(
                      "${LocaleKeys.totalPrice}: ${myPair.orders.quantity! * myPair.offer!.totalPrice!}")
                  : Text(
                      "${LocaleKeys.totalPrice}: ${myPair.orders.quantity! * myPair.book!.sellingPrice!}"),
              Text("${LocaleKeys.quantity}: ${myPair.orders.quantity}"),
              myPair.book != null ? Text("${myPair.book!.state}") : Text(""),
            ],
          ),
          trailing: IconButton(
              onPressed: () {
                _cubit.remove(myPair);
                print("object");
              },
              icon: Icon(
                Icons.delete_forever_rounded,
                color: MyColors.myPurble,
              )),
        ),
      ),
    );
  }
}
