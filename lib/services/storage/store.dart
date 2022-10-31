import 'package:book_nook_user/data/models/user.dart';
import 'package:get_storage/get_storage.dart';

class Store {
  Store() {
    store = GetStorage();
  }

  static late User myUser;
  static String? token;
  static bool is_verify = false;
  static String? fcmToken;
  static int? state;
  static late GetStorage store;
  // static GlobalKey<RefreshIndicatorState>? homeRefreshIndicatorKey;
  // static GlobalKey<RefreshIndicatorState>? myProductsRefreshIndicatorKey;
  static String baseURL = "http://192.168.236.216:8000"; 
  //'http://192.168.43.216:8000';
  //'http://192.168.1.3:8000';'http://192.168.1.15:8000';
  // '';"https://www.magellanit.com";
  // 'http:// 192.168.43.216:8000' 'http://192.168.43.216:8000'; 192.168.1.3
}


