// import 'package:flutter/material.dart';


import 'package:book_nook_user/data/models/Book.dart';
import 'package:flutter/material.dart';

var screenSize, screenHeight, screenWidth;

const TextStyle h1 = TextStyle(fontSize: 28);
TextStyle h2 = const TextStyle(fontSize: 24);
TextStyle p1 = const TextStyle(fontSize: 18);
TextStyle p2 = const TextStyle(fontSize: 15, fontWeight: FontWeight.w300);
TextStyle p3 = const TextStyle(fontSize: 12, fontWeight: FontWeight.w300);
TextStyle buttonfont = const TextStyle(fontSize: 16);

List<Category> categories = [

  Category(id: 0,name: "All"),
  Category(id:0,name: "Favorite Categories"),
  Category(id: 1,name: "Classics"),
  Category(id: 2,name: "Action"),
  Category(id: 3,name: "Horror"),
  Category(id: 4,name: "Crime"),
  Category(id: 5,name: "True Crime"),
  Category(id: 6,name: "Fantasy"),
  Category(id: 7,name: "Historical Fiction"),
  Category(id: 8,name: "Adventure"),
  Category(id: 9,name: "Graphic Novel"),
  Category(id: 10,name: "Comic Book"),
  Category(id: 11,name: "Humor"),
  Category(id: 12,name: "Mystery"),
  Category(id: 13,name: "Romance"),
  Category(id: 14,name: "Poetry"),
  Category(id: 15,name: "Cookbooks"),
  Category(id: 16,name: "Science Fiction"),
  Category(id: 17,name: "Children Book"),
  Category(id: 18,name: "Health and Fitness"),
  Category(id: 19,name: "Biography"),
  Category(id: 20,name: "Religion"),
  Category(id: 21,name: "Education"),
];
