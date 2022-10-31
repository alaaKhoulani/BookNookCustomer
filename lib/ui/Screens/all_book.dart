import 'package:book_nook_user/business_logic/cubit/home_page/home_page_cubit.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/ui/Screens/HomePage.dart';
import 'package:book_nook_user/ui/widgets/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../consts/constant.dart';
import '../../../consts/myColors.dart';

class AllBook extends StatefulWidget {
  final List<BookInfo> books;
  const AllBook({Key? key, required this.books}) : super(key: key);

  @override
  State<AllBook> createState() => _AllBookState();
}

class _AllBookState extends State<AllBook> {
  @override
  Widget build(BuildContext context) {
    var _cubit = BlocProvider.of<HomePageCubit>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyColors.myBlack, //change your color here
        ),
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        toolbarHeight: 70,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "${categories[_cubit.selectedCategory].name}",
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7,
                      childAspectRatio: 0.6),
                  itemCount: widget.books.length,
                  itemBuilder: (context, index) {
                    return _bookItem(book: widget.books[index]);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookItem({required BookInfo book}) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(100),
                  child: book.image!.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          image: ("${Store.baseURL}/${book.image!}"),
                          // fit: BoxFit.cover,
                          placeholder: "assets/images/book1.png",
                        )
                      : Image(image: AssetImage("assets/images/book1.png")),
                ),
              ),
              decoration: BoxDecoration(
                // color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              )),
          Container(
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
        ],
      ),
    );
  }
}
