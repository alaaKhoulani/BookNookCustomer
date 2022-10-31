import 'package:book_nook_user/business_logic/cubit/order/order_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/data/models/recieve_order.dart';
import 'package:book_nook_user/data/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
//  late Data _detailes;
  List<RecieveOrder> orders = [];
  @override
  TextEditingController starConroller = TextEditingController();
  void initState() {
    // TODO: implement initState
    super.initState();
    print('myorder');
    BlocProvider.of<OrderCubit>(context).getOrders();
    // OrderRepository().getOrders();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My order", //ToDO:translate
          style: TextStyle(color: MyColors.myPurble),
        ),
        backgroundColor: MyColors.myWhite,
      ),
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is OrderGetListInitial) {
            return _buildLoaddingListWidget();
          }
          this.orders = (state as OrderGetListSuccessful).orders;
          return ListView.builder(
              // physics: ClampingScrollPhysics(),
              // shrinkWrap: true,
              itemCount: this.orders.length,
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          // offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      color: MyColors.myWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Expanded(
                      child: ListTile(
                        title: Text("Order  ${index + 1}"),//ToDo:Translate
                        subtitle: Text(" from:  ${this.orders[index].library!.libraryName}"),
                        trailing: IconButton(
                            onPressed: () async {
                              await _showMyDialog(context);
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: MyColors.myPurble,
                              size: 20,
                            )),
                      ),
                    ));
              });
        },
      ),
    );
  }
}

Widget _buildLoaddingListWidget() {
  return ListView.builder(
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
      });
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            //ToDO:
            // title: Row(children: [
            //   Text("${books}")
            // ]),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                return Container(
                  height: 500,
                  width: 300,
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: ClampingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(18),
                        child: ListTile(
                          title: Container(
                            child: Text("name"),
                          ),
                          leading: Image.asset("assets/books/the law.jpg"),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close",
                    style: buttonfont.copyWith(color: MyColors.myBlack),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text("Add to card",
                      style: buttonfont.copyWith(
                        color: MyColors.myPurble,
                      ))),
            ],
          ));
}
