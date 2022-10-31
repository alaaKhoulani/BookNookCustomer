import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/models/order.dart';
import 'package:book_nook_user/data/models/pair.dart';
import 'package:book_nook_user/data/models/recieve_order.dart';
import 'package:book_nook_user/data/repository/order_repository.dart';
import 'package:book_nook_user/data/web_services/order_web_services.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  OrderRepository _orderRepository = OrderRepository();

  List<MyPair> myPair = [];
  void add(MyPair myPair) {
    this.myPair.add(myPair);
    emit(OrderAddToList(this.myPair));
  }

  void remove(MyPair myPair) {
    List<MyPair> _temp = this.myPair;
    _temp.remove(myPair);
    this.myPair = _temp;
    emit(OrderRemoveFromList(this.myPair));
  }

  Future<void> postOrder() async {
    emit(OrderInitial());
    int totalPrice = 0;
    Order order = Order();
    order.orderes = [];
    for (int i = 0; i < myPair.length; i++) {
      order.orderes!.add(myPair[i].orders);
      if (myPair[i].orders.type == "offer") {
        totalPrice += myPair[i].offer!.totalPrice! * myPair[i].orders.quantity!;
      } else {
        totalPrice +=
            myPair[i].orders.quantity! * myPair[i].book!.sellingPrice!;
      }
    }
    order.totalPrice = totalPrice;

    order.addressId = 1;
    order.libraryId = 1;
    // if (myPair[0].book == null)
    //   order.libraryId = myPair[0].offer!.libraryId;
    // else
    //   myPair[0].book!.library;

    await OrderWebServices().PostOrder(order);
    emit(OrderPostSuccessgul());
    return;
  }

  Future<void> getOrders() async {
    emit(OrderGetListInitial());
    List<RecieveOrder> ordersList = [];
    ordersList = await _orderRepository.getOrders();
    emit(OrderGetListSuccessful(ordersList));
  }
}
