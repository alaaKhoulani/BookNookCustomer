import 'package:book_nook_user/business_logic/cubit/book_in_library/book_in_library_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/library/library_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/offer/offer_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/order/order_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/data/models/libraryProfile.dart';
import 'package:book_nook_user/data/models/offers.dart';
import 'package:book_nook_user/data/models/order.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/translate/locale_keys.g.dart';
import 'package:book_nook_user/ui/Screens/all_book.dart';
import 'package:book_nook_user/ui/widgets/CategoriesRow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class LibraryScreen extends StatefulWidget {
  final int id;
  const LibraryScreen({super.key, required this.id});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<BookInfo> booksInLibrary = [];
  List<Offer> offers = [];

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();

    BlocProvider.of<LibraryCubit>(context).getLibraryInfo(id: widget.id);

    BlocProvider.of<BookInLibraryCubit>(context)
        .getBooks(id: widget.id)
        .then((value) => this.booksInLibrary = value);

    BlocProvider.of<OfferCubit>(context)
        .getLibraryOffers(id: widget.id)
        .then((value) => this.offers = value);
    // print("init");
    // print(this.offers.length);

    _tabController.addListener(() {
      // print("${_tabController.index}");
      if (_tabController.index == 0) {
        BlocProvider.of<LibraryCubit>(context)
            .getLibraryInfo(id: widget.id)
            .then((value) => null);
      } else if (_tabController.index == 1) {
        BlocProvider.of<BookInLibraryCubit>(context)
            .getBooks(id: widget.id)
            .then((value) => null);
      } else {
        BlocProvider.of<OfferCubit>(context)
            .getLibraryOffers(id: widget.id)
            .then((value) => this.offers = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    return Scaffold(
        body: BlocConsumer<LibraryCubit, LibraryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LibraryLoading) {
          return _buildLoaddingListWidget();
        } else if (state is LibrarySuccessfull) {
          LibraryProfile libraryProfile = state.libraryProfile;
          return _buildSuccessFullWidget(libraryProfile);
        } else
          return Container(
            color: Colors.red,
          );
      },
    ));
  }

  Widget _buildSuccessFullWidget(LibraryProfile libraryProfile) {
    return Column(
      children: [
        Container(
          height: (screenHeight * (0.3)),
          width: screenWidth,
          child: Image(image: AssetImage("assets/images/book1.png")),
          // child: libraryProfile.libraryInfo!.image != null
          //     ? FadeInImage.assetNetwork(
          //         fit: BoxFit.cover,
          //         image:
          //             ("${Store.baseURL}/${libraryProfile.libraryInfo!.image!}"),
          //         // fit: BoxFit.cover,
          //         placeholder: "assets/images/book1.png",
          //       )
          //     : Image(image: AssetImage("assets/images/book1.png")),
        ),
        Container(
          height: 50,
          color: MyColors.myGreen,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
                // decoration: BoxDecoration(
                // color: MyColors.myBlack,
                // borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text("asdf",
                    style: p1.copyWith(color: MyColors.myBlack)),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 7, 30, 7),
                // decoration: BoxDecoration(
                //     color: MyColors.myBlack,
                //     borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text("online",
                    style: p1.copyWith(
                        color: libraryProfile.libraryInfo!.status == "online"
                            ? Colors.green
                            : Colors.grey[600])),
              ),
            ],
          ),
        ),
        TabBar(
            onTap: (value) {
              // print(value);
              // if (value == 0) {
              //   BlocProvider.of<LibraryCubit>(context)
              //       .getLibraryInfo(id: widget.id)
              //       .then((value) => null);
              // } else if (value == 1) {
              //   BlocProvider.of<BookInLibraryCubit>(context)
              //       .getBooks(id: widget.id)
              //       .then((value) => null);
              // } else {
              //   BlocProvider.of<OfferCubit>(context)
              //       .getLibraryOffers(id: widget.id)
              //       .then((value) => this.offers = value);
              // }
            },
            controller: _tabController,
            tabs: [
              _tabTitle(LocaleKeys.description.tr()),
              _tabTitle(LocaleKeys.books.tr()),
              _tabTitle(LocaleKeys.offers.tr()),
            ]),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            _descriptionBar(libraryProfile),
            _booksTab(),
            _buildOfferWidget()
          ]),
        )
      ],
    );
  }

  Widget _descriptionBar(LibraryProfile libraryProfile) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: ListView(padding: EdgeInsets.all(0), children: [
        _textEscription(
            "${LocaleKeys.contact.tr()}:   ${libraryProfile.libraryInfo!.phoneNumber}"),
        _textEscription("${LocaleKeys.email.tr()}:   ${libraryProfile.email!}"),
        _textEscription(
            "${LocaleKeys.openTime.tr()}:   ${libraryProfile.libraryInfo!.openTime}"),
        _textEscription(
            "${LocaleKeys.closeTime.tr()}:   ${libraryProfile.libraryInfo!.closeTime}"),
        // _textEscription("Contact:   0987654321"),
        _textEscription(libraryProfile.libraryAddress!.details == null
            ? "${LocaleKeys.address.tr()}: ${libraryProfile.libraryAddress!.area}  ${libraryProfile.libraryAddress!.street}  ${libraryProfile.libraryAddress!.floor}  ${LocaleKeys.near.tr()} ${libraryProfile.libraryAddress!.near} "
            : "${LocaleKeys.address.tr()}: ${libraryProfile.libraryAddress!.area}  ${libraryProfile.libraryAddress!.street}  ${libraryProfile.libraryAddress!.floor}  ${LocaleKeys.near.tr()} ${libraryProfile.libraryAddress!.near}  ${libraryProfile.libraryAddress!.details}")
      ]),
    );
  }

  Widget _textEscription(String lable) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Text(
        lable,
        style: p2,
      ),
    );
  }

  Widget _booksTab() {
    return BlocListener<BookInLibraryCubit, BookInLibraryState>(
      listener: (context, state) {
        if (state is BookGetInLibraryInitial) {
          _buildLoaddingListWidget();
        } else if (state is LibraryGetBooksSuccessful) {
          this.booksInLibrary = state.allBooks;
        } else {
          _showMyDialog(context);
        }
      },
      child: GridView.builder(
          padding: EdgeInsets.all(10),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 7,
              crossAxisSpacing: 7,
              childAspectRatio: 0.6),
          itemCount: this.booksInLibrary.length, //widget.books.length,
          itemBuilder: (context, index) {
            return _bookItem(book: this.booksInLibrary[index]);
          }),
    );
  }

  Widget _tabTitle(String lable) {
    return Tab(
        // icon: ,
        child: Text(
      lable,
      style: p2.copyWith(color: MyColors.myBlack),
    ));
  }

  Widget _bookItem({required BookInfo book}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "details", arguments: book);
      },
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(100),
                  // child: Image.asset("assets/images/book1.png"),
                  child: book.image!.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          // fit: BoxFit.cover,
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
        });
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

  Widget _buildOfferWidget() {
    return BlocListener<OfferCubit, OfferState>(
      listener: (context, state) {
        if (state is OfferInitial) {
          _buildLoaddingListWidget();
        } else if (state is OfferGetSuccessful) {
          // Navigator.pop(context);
          this.offers = state.offers;
        } else {
          _showMyDialog(context);
        }
      },
      child: ListView.builder(
          // physics: ClampingScrollPhysics(),
          // shrinkWrap: true,
          itemCount: this.offers.length,
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
                    title: Text("${offers[index].title}"),
                    subtitle: Text("    price:  ${offers[index].totalPrice}"),
                    trailing: IconButton(
                        onPressed: () async {
                          await _showMyDialogOffer(context, "name",
                              this.offers[index].books!, index);
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: MyColors.myPurble,
                          size: 20,
                        )),
                  ),
                ));
          }),
    );
  }

  Future<void> _showMyDialogOffer(BuildContext context, String lable,
      List<BookInfo> books, int index) async {
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
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(18),
                          child: ListTile(
                            title: Container(
                              child: Text("${books[index].name}"),
                            ),
                            leading: books[index].image!.isNotEmpty
                                ? FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    image:
                                        ("${Store.baseURL}/${books[index].image!}"),
                                    // fit: BoxFit.cover,
                                    placeholder: "assets/images/book1.png",
                                  )
                                : Image(
                                    image:
                                        AssetImage("assets/images/book1.png")),
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
                    onPressed: () {
                      Navigator.pushNamed(context, "buyOffer",
                          arguments: this.offers[index]);
                    },
                    child: Text("Add to card",
                        style: buttonfont.copyWith(
                          color: MyColors.myPurble,
                        ))),
              ],
            ));
  }
}
