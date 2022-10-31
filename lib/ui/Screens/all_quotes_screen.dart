import 'package:book_nook_user/business_logic/cubit/quotes/quotes_cubit.dart';
import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/data/models/quote.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/services/validate/validation.dart';
import 'package:book_nook_user/translate/locale_keys.g.dart';
import 'package:book_nook_user/ui/widgets/inputCard.dart';
import 'package:book_nook_user/ui/widgets/loaading_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AllQuotes extends StatefulWidget {
  AllQuotes({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<AllQuotes> createState() => _userinfoState();
}

class _userinfoState extends State<AllQuotes> {
  List<Quote> quotes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<QuotesCubit>(context)
        .getBookQuotes(id: widget.id)
        .then((value) => null);
  }

  TextEditingController quoteController = TextEditingController();
  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _cubit = BlocProvider.of<QuotesCubit>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(LocaleKeys.quotes.tr(),
              style: h2.copyWith(
                color: MyColors.myBlack,
              )),
          elevation: 0,
          backgroundColor: MyColors.myWhite,
        ),
        body: BlocConsumer<QuotesCubit, QuotesState>(
          listener: (context, state) {
            if (state is QuotesPostSubmetting) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return LoadingDialog();
                },
              );
            } else if (state is QuotesPostSuccess) {
              Navigator.pop(context);
              BlocProvider.of<QuotesCubit>(context)
                  .getBookQuotes(id: widget.id);
            } else if (state is QuotesFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text((state.exception.toString() + '.'))));
            }
          },
          builder: (context, state) {
            if (state is QuotesInitial ||
                state is QuotesPostSubmetting ||
                state is QuotesPostSuccess) {
              return _buildLoaddingListWidget();
            } else if (state is QuotesSuccess) {
              this.quotes = state.quotes;
              return _buildSuccessWidget(context);
            } else {
              _showMyDialog(context);
              return Container();
            }
          },
        ));
  }

  Widget _buildSuccessWidget(BuildContext context) {
    var _cubit = BlocProvider.of<QuotesCubit>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: quoteController,
                    decoration: InputDecoration(
                        hintText: LocaleKeys.addQuote.tr(),
                        hintStyle: p2.copyWith(color: MyColors.myBlack),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    autofocus: false,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (quoteController.value.text.isNotEmpty &&
                        quoteController.value.text != null) {
                      await _cubit.addQuote(
                          quote: quoteController.value.text, id: widget.id);
                      quoteController.clear();
                      await _cubit.getBookQuotes(id: widget.id);
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: MyColors.myPurble,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  var _cubit = BlocProvider.of<QuotesCubit>(context);
                  return Column(
                    children: [
                      _quote(
                          index: index,
                          // image: quotes[index].image!,
                          name: quotes[index].role_id != 1
                              ? "${quotes[index].firstName} ${quotes[index].firstName}"
                              : "${quotes[index].library}",
                          quote: "${quotes[index].quote}"),
                          Store.myUser.userId == this.quotes[index].userId
                          ? Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _showMyDialogEdit(context,this.quotes[index].id!);
                                      editingController.text =
                                          this.quotes[index].quote!;
                                    },
                                    icon: Icon(Icons.edit_calendar_sharp)),
                                IconButton(
                                    onPressed: () {
                                      _showMyDialogRemove(
                                          context, this.quotes[index].id!);
                                    },
                                    icon: Icon(Icons.remove_circle))
                              ],
                            )
                          : Container(),
                    ],
                  );
                }),
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
          title: Text(LocaleKeys.failuer.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Text('This is a demo alert dialog.'),
                Text(LocaleKeys.pleaseswaptotryagain.tr()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(LocaleKeys.ok.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _quote(
      {required String name,
      required String quote,
      // required String image,
      required int index}) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      // height: 160,
      // width: 300,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            // offset: Offset(0, 0), // changes position of shadow
          ),
        ],
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: CircleAvatar(
                  backgroundColor: MyColors.myGreen,
                  child: Text('HD'),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(name,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                      ))),
            ],
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                quote,
              )),
          Store.myUser.userId == this.quotes[index].userId
              ? Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit_calendar_sharp)),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.remove_circle))
                  ],
                )
              : Container()
        ],
      ),
    );
  }
  
  Future<void> _showMyDialogRemove(BuildContext context, int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text("Are you shure to remove your comment"), // TODO: translate
          content: SingleChildScrollView(
              child: feild(editingController, "", 43,
                  Validation.validateRegisterFullName, context)),
          actions: <Widget>[
            TextButton(
              child: Text(LocaleKeys.ok.tr()),
              onPressed: () {
                BlocProvider.of<QuotesCubit>(context).deletQuote(id: id);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(LocaleKeys.ok.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogEdit(BuildContext context,int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("edite your comment"), // TODO: translate
          content: SingleChildScrollView(
              child: Column(
            children: [
              feild(editingController, "", 43,
                  Validation.validateRegisterFullName, context),
              // MyButton(
              //   context: context,
              //   fun: () {},
              //   child: Text("Done",
              //       style: buttonfont.copyWith(
              //         color: MyColors.myWhite,
              //       )),
              // ),
            ],
          )),
          actions: <Widget>[
            TextButton(
              child: Text(
                LocaleKeys.ok.tr(),
                style: buttonfont.copyWith(color: MyColors.myBlack),
              ),
              onPressed: () {
                BlocProvider.of<QuotesCubit>(context).UpdateQuote(
                  id:id,
                  value: editingController.value.text,
                );
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              //TODO: Edit
              child: Text("Edit",
                  style: buttonfont.copyWith(color: MyColors.myPurble)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget feild(TextEditingController controller, String name, double spaceWidth,
      FormFieldValidator<String> validate, BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$name"),
        SizedBox(
          width: spaceWidth,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: InputCard(
                  name: "$name",
                  controller: controller,
                  vlaidate: validate,
                ),
              ),
              name == "Authors" || name == "Category"
                  ? IconButton(onPressed: () {}, icon: Icon(Icons.send_rounded))
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}
