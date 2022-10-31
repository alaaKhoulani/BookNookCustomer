import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/ui/widgets/expanded_content_widget.dart';
import 'package:book_nook_user/ui/widgets/image_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatefulWidget {
  final BookInfo book;

  const LocationWidget({
    required this.book,
    Key? key,
  }) : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Container(
            //   height: size.height * 0.5,
            //   // width: size.width*0.3,
            // ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              bottom: isExpanded ? 0 : 60,
              width: isExpanded ? size.width * 0.55 : size.width * 0.4,
              height: isExpanded ? size.height * 0.48 : size.height * 0.3,
              child: ExpandedContentWidget(book: widget.book),
            ),
            GestureDetector(
              child: AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                bottom: isExpanded ? 100 : 40,
                child: GestureDetector(
                  onPanUpdate: onPanUpdate,
                  onTap: () {
                    print("pressed");
                    Navigator.pushNamed(context, "details",
                        arguments: widget.book);
                  },
                  child: ImageWidget(book: widget.book),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}
