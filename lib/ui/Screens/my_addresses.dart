import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/data/models/address.dart';
import 'package:book_nook_user/ui/Screens/addAddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../consts/myColors.dart';

class MyAddresses extends StatefulWidget {
  const MyAddresses({super.key});

  @override
  State<MyAddresses> createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {

  @override
  void initState() {
    super.initState();
    //ToDo: get addresss from api
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyColors.myPurble, //change your color here
        ),
        title: Text("My Adresses",
            style: p1.copyWith(
              color: MyColors.myPurble,
            )),
        elevation: 0,
        backgroundColor: MyColors.myWhite,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          add(context),
          Container(
            child: ListView.builder(
              //ToDo:
              itemCount: 5,
              itemBuilder: (context, index) {
                return _myCard(Address());
              },
            ),
          ),
        ],
      )),
    );
  }

  Widget add(BuildContext context) {
    // var _cubit = BlocProvider.of<>(context);
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, 'addAddress');
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
            "add an address",
            style: p1.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _myCard(Address address) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Card(
        color: MyColors.myGrey,
        child: ListTile(
          title: Text(address.title.toString()),
          subtitle: Text(address.area.toString()),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: MyColors.myPurble,
              )),
        ),
      ),
    );
  }
}
