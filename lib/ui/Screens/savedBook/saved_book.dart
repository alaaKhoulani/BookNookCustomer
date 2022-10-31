// import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'saved_book_cubit.dart';
import 'saved_book_states.dart';
import 'model.dart';

// import '../../../consts/constant.dart';
// import '../../../consts/myColors.dart';

class SavedBook extends StatefulWidget {
  const SavedBook({Key? key}) : super(key: key);

  @override
  State<SavedBook> createState() => _SavedBookState();
}

class _SavedBookState extends State<SavedBook> {
  List<Book> savedBooks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cubit = SavedBookCubit.get(context);
    cubit.getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavedBookCubit, SavedBookStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is initial) {
            return _buildLoaddingListWidget();
          } else if (state is GetData) {
            print("hiiiiiiiiiiiiiii");
            final cubit = SavedBookCubit.get(context);
            this.savedBooks = cubit.sevedBooks;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: MyColors.myBlack, //change your color here
                ),
                toolbarHeight: 70,
                elevation: 0,
                title: Text(
                  "Saved Books",
                  style: p1.copyWith(color: MyColors.myBlack),
                ),
                backgroundColor: MyColors.myWhite,
              ),
              //backgroundColor: MyColors().test4,
              body: Container(
                //margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // SearchBox(),
                      GridView.builder(
                          padding: EdgeInsets.all(10),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 7,
                                  crossAxisSpacing: 7,
                                  childAspectRatio: 0.6),
                          itemCount: this.savedBooks.length,
                          itemBuilder: (context, index) {
                            return _bookItem(
                                book: this.savedBooks[index],
                                index: index % 6);
                          }),
                    ],
                  ),
                ),
              ),
              // floatingActionButton: FloatingActionButton(
              //     child: Icon(Icons.add),
              //     onPressed: () {
              //       cubit.getSavedBookApi();
              //     }),
            );
          } else {
            return Container();
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

  Widget _bookItem({required Book book, required int index}) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Expanded(
            child: Container(
                margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(100),
                    child: book.image == null
                        ? Image.asset("assets/images/book1.png")
                        : FadeInImage.assetNetwork(
                            fit: BoxFit.fill,
                            image: ("${Store.baseURL}/${book.image}"),
                            // fit: BoxFit.cover,
                            placeholder: "assets/images/book1.png",
                          ),
                    // child: Image(
                    //     image: AssetImage("assets/images/cover$index.jpg"),
                    //     fit: BoxFit.cover),
                  ),
                ),
                decoration: BoxDecoration(
                  // color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                )),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              // margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
              padding: EdgeInsets.all(5),
              child: Text(
                book.name!,
                style: p2.copyWith(
                  color: MyColors.myBlack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
