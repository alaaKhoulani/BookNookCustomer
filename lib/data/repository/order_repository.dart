import 'package:book_nook_user/data/models/order.dart';
import 'package:book_nook_user/data/models/recieve_order.dart';
import 'package:book_nook_user/data/web_services/order_web_services.dart';

class OrderRepository {
  OrderWebServices _orderWebRepository = OrderWebServices();

  Future<List<RecieveOrder>> getOrders() async {
    print("===============");
    List<RecieveOrder> list = [];
    List json = await _orderWebRepository.getOrders();
    for (var i = 0; i < json.length; i++) {
      list.add(RecieveOrder().fromJson(json[i]));
    }
    print(list);
    return list;
  }
}
