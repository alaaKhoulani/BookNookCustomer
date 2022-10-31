import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/data/models/address.dart';
import 'package:book_nook_user/data/models/order.dart';
import 'package:book_nook_user/data/models/user.dart';

class RecieveOrder {
  User? user;
  Library? library;
  Address? address;
  int? totalPrice;
  List<Orderes>? orders;
  int? id;

  RecieveOrder(
      {this.address, this.library, this.orders, this.totalPrice, this.user,this.id});

  RecieveOrder fromJson(Map<String, dynamic> json) {
    return RecieveOrder(
            user: User().fromJson(json["user"]),
      library: Library().fromJson1(json["library"]),
      address: Address().fromJson(json["address"]),
      totalPrice: json["totalPrice"],
      id: json["id"],
      orders: Orderes().fromJsonList(json["sub_orders"])
    ) ;
  }
}
