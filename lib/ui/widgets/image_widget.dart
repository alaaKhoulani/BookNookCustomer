import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final BookInfo book;

  const ImageWidget({
    required this.book,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      width: size.width * 0.5,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 1),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: buildImage(),
      ),
    );
  }

  Widget buildImage() => ClipRRect(
        borderRadius: BorderRadius.circular(10), // Image border

        child: book.image!.isNotEmpty
            ? FadeInImage.assetNetwork(
                fit: BoxFit.fill,
                image: ("${Store.baseURL}/${book.image!}"),
                // fit: BoxFit.cover,
                placeholder: "assets/images/book1.png",
              )
            : Image(image: AssetImage("assets/images/book1.png")),
      );

  Widget buildTopText() => Text(
        book.name!,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
}
