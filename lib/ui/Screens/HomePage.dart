import 'dart:math';
import 'package:book_nook_user/business_logic/cubit/all_book/all_book_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/home_page/home_page_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/translate/locale_keys.g.dart';
import 'package:book_nook_user/ui/widgets/CategoriesRow.dart';
import 'package:book_nook_user/ui/widgets/Search.dart';
import 'package:book_nook_user/ui/widgets/book_Item.dart';
import 'package:book_nook_user/ui/widgets/loaading_dialog.dart';
import 'package:book_nook_user/ui/widgets/location_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

// import '../../translate/locale_keys.g.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(initialPage: 1, viewportFraction: 0.6);
    BlocProvider.of<HomePageCubit>(context)
        .getAllBooks()
        .then((value) => this.books = value);
    BlocProvider.of<AllBookCubit>(context)
        .getTopRatedBooks()
        .then((value) => this.topRatedBooks = value);
  }

  List<BookInfo> books = [];
  List<BookInfo> topRatedBooks = [];
  Widget title(String title, double fontsize) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: h1.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  bool isEnglish = true;
  @override
  Widget build(BuildContext context) {
    var searchWidget = SearchBox();

    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: MyColors.myWhite,
          elevation: 0,
          actions: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: DropdownButton(
                      icon: Icon(Icons.language),
                      // hint: Text("language"),
                      items: [
                        DropdownMenuItem(
                          child: Text("English"),
                          value: "en",
                          onTap: () async {
                            await context.setLocale(const Locale('en'));
                          },
                        ),
                        DropdownMenuItem(
                          child: Text("Arabic"),
                          value: "ar",
                          onTap: () async {
                            await context.setLocale(const Locale('ar'));
                          },
                        ),
                      ],
                      onChanged: (value) => {}),
                ),
              ],
            ),
          ]),
      body: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is HomePageInitial) {
            return _buildLoaddingListWidget();
          } else if (state is HomePageISuccessfull) {
            this.books = state.books;
            // this.topRatedBooks = state.books;
            return _buildSuccessFullWifget(
                this.books, this.topRatedBooks, context);
          } else {
            _showMyDialog(context);
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildLoaddingListWidget() {
    // return Column(
    //   children: [
    //     SingleChildScrollView(
    //       child: Row(
    //         children: [
    //           Shimmer.fromColors(
    //             baseColor: Colors.grey.shade300,
    //             highlightColor: Colors.grey.shade100,
    //             child: Container(
    //               color: Colors.red,
    //               padding: EdgeInsets.zero,
    //               width: 100,
    //               alignment: Alignment.center,
    //               margin: EdgeInsets.all(8),
    //             ),
    //           ),
    //           Shimmer.fromColors(
    //             baseColor: Colors.grey.shade300,
    //             highlightColor: Colors.grey.shade100,
    //             child: Container(
    //               padding: EdgeInsets.zero,
    //               width: 100,
    //               alignment: Alignment.center,
    //               margin: EdgeInsets.all(8),
    //             ),
    //           ),
    //           Shimmer.fromColors(
    //             baseColor: Colors.grey.shade300,
    //             highlightColor: Colors.grey.shade100,
    //             child: Container(
    //               padding: EdgeInsets.zero,
    //               width: 100,
    //               alignment: Alignment.center,
    //               margin: EdgeInsets.all(8),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     SingleChildScrollView(
    //       child: Row(
    //         children: [
    //           Shimmer.fromColors(
    //             baseColor: Colors.grey.shade300,
    //             highlightColor: Colors.grey.shade100,
    //             child: Container(
    //               padding: EdgeInsets.zero,
    //               width: 200,
    //               height: 300,
    //               alignment: Alignment.center,
    //               margin: EdgeInsets.all(8),
    //             ),
    //           ),
    //           Shimmer.fromColors(
    //             baseColor: Colors.grey.shade300,
    //             highlightColor: Colors.grey.shade100,
    //             child: Container(
    //               padding: EdgeInsets.zero,
    //               width: 200,
    //               height: 300,
    //               alignment: Alignment.center,
    //               margin: EdgeInsets.all(8),
    //             ),
    //           ),
    //           Shimmer.fromColors(
    //             baseColor: Colors.grey.shade300,
    //             highlightColor: Colors.grey.shade100,
    //             child: Container(
    //               padding: EdgeInsets.zero,
    //               width: 200,
    //               height: 300,
    //               alignment: Alignment.center,
    //               margin: EdgeInsets.all(8),
    //             ),
    //           ),
    //         ],
    //       ),
    //     )
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
              height: 400,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Row(
                    children: [
                      Container(
                        width: 250,
                        height: 400,
                        decoration: BoxDecoration(
                            color: MyColors.myWhite,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ],
                  )));
        });
  }

  Widget _buildSuccessFullWifget(
      List<BookInfo> books, List<BookInfo> rated, BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 60,
            // ),
            // searchWidget,
            const SizedBox(
              height: 20,
            ),
            title(LocaleKeys.explore.tr(), 40),
            SizedBox(
              height: 20,
            ),
            CategoriesRow(),
            _buildRowOfBooks(books),
            title("Top rated", 40), //ToDO translate
            _buildTopRated(topRatedBooks)
          ],
        ),
      ),
    );
  }

  Widget _buildTopRated(List<BookInfo> topRatedBooks) {
    return Container(
        // color: Colors.amber,
        alignment: Alignment.bottomCenter,
        width: double.infinity,
        // height: screenHeight / 2,
        child: PageView.builder(
            itemCount: min(6, topRatedBooks.length),
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _bookItem(book: topRatedBooks[index]);
            }));
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

  Widget _buildRowOfBooks(List<BookInfo> books) {
    return Container(
      // color: Colors.amber,
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      height: screenHeight / 2,
      child: PageView.builder(
        itemCount: books.length,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        // scrollDirection: Axis.horizontal,
        // padding: EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return books.length == 0
              ? Center(
                  child: Container(
                  child: Text("No Item exist"), //ToDo: translate
                ))
              : index == books.length
                  ? IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "allBook",
                            arguments: books);
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded))
                  : LocationWidget(book: books[index]);
        },
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failer'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text('This is a demo alert dialog.'),
                Text('Some thing went wrong !!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// Class which draws the custom shape
// class DrawerPainter extends CustomPainter {
//   final Color color;
//   DrawerPainter({this.color = Colors.black});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = color
//       ..strokeWidth = 3
//       ..style = PaintingStyle.fill;
//     canvas.drawPath(getShapePath(size.width, size.height), paint);
//   }

//   // This is the path of the shape we want to draw
//   Path getShapePath(double x, double y) {
//     return Path()
//       ..moveTo(0, 0)
//       ..lineTo(x / 2 - 20, 0)
//       ..quadraticBezierTo(x, y / 2, x / 2 + 40, y)
//       ..lineTo(0, y);
//   }

//   @override
//   bool shouldRepaint(DrawerPainter oldDelegate) {
//     return oldDelegate.color != color;
//   }

