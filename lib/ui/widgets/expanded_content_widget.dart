import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:flutter/material.dart';

class ExpandedContentWidget extends StatelessWidget {
  final BookInfo book;

  const ExpandedContentWidget({
    required this.book,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    // height: screenHeight/3,
        decoration: BoxDecoration(
        
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(book.name!),
            SizedBox(height: 8),
            buildAddressRating(book: book),
            SizedBox(height: 12),
            // buildReview(book: Book("name", "", 4))
          ],
        ),
      );

  Widget buildAddressRating({
    required BookInfo book,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${book.state}",
            style:book.state=="new"?p1.copyWith(color: Colors.green) : p1.copyWith(color: Colors.red) ,
          ),
          // StarsWidget(stars: location.starRating),
        ],
      );

  // Widget buildReview({
  //   required Book book,
  // }) =>
  //     Row(
  //       children: book.reviews
  //           .map((review) => Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 4),
  //                 child: CircleAvatar(
  //                   radius: 16,
  //                   backgroundColor: Colors.black12,
  //                   backgroundImage: AssetImage(review.urlImage),
  //                 ),
  //               ))
  //           .toList(),
  //     );
}
