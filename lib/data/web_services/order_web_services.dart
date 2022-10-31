import 'dart:convert';
import 'dart:io';

import 'package:book_nook_user/data/models/order.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:http/http.dart' as http;

class OrderWebServices {
  Future<void> PostOrder(Order order) async {
    try {
      Map<String, dynamic> data = {};
      // data = order.toJson();
      data.addAll({"totalPrice": order.totalPrice.toString()});
      data.addAll({"library_id": order.libraryId.toString()});
      data.addAll({"address_id": "1"});

      for (int i = 0; i < order.orderes!.length; i++) {
        data.addAll(
            {"orderes[$i][book_id]": order.orderes![i].bookId.toString()});
        data.addAll({"orderes[$i][type]": order.orderes![i].type.toString()});
        data.addAll(
            {"orderes[$i][quantity]": order.orderes![i].quantity.toString()});
        data.addAll(
            {"orderes[$i][offer_id]": order.orderes![i].offerId.toString()});
      }

      print("data");
      print(data);
      var response = await http.post(Uri.parse("${Store.baseURL}/api/order/"),
          headers: {
            "Accept": "application/json",
            "Authorization": 'Bearer ${Store.token}',
          },
          body: data);

      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print("object");
      print(responseBody);
      if (responseBody["statue code"] == 200 && response.statusCode == 200) {
        return responseBody["data"];
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      // throw Exception("Something went wrong");
      // return [];
    }
  }

  //----------------------- show my orders-----------------------------------------
  Future<List> getOrders() async {
    try {
      var response = await http.get(
        Uri.parse("${Store.baseURL}/api/order/user_orderes"),
        headers: {
          "Accept": "application/json",
          "Authorization":
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzY3NThkNzcyODMyMzhmYjAzNDc4OWUzNDBkNDg3MDYzYzlkODBhMjE5NjdhN2ZhM2NmMzhhMTUxNDM0ODAyYTM0NTFkZjQ3ZDIwNTVmYjYiLCJpYXQiOjE2NjAyMjY1MDYuMjE4MjQ0LCJuYmYiOjE2NjAyMjY1MDYuMjE4MjQ2LCJleHAiOjE2OTE3NjI1MDYuMjE0NjM5LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.ZEyYcfB-EIg3LDd5u0Qq8L0DEb59M9r6X0Vy1AIxGbUifHArGiT3s0hIPCNNIhXRnLGN9ih9AqdwNolj5iZvnfuAn77z0yApDeKdq38LqzGcSbIFe4a0OLM6h2z938LFr46F087L3Tc7-nGhkl2Izkl9z9OgQsgScqSrcZoZzAFdsIba25NVYWV_5lKvFtJKWg5LDlI64sB5SZuPmUwWNXbCjcB4hnKkz9z-NHMT1JZR-j3ysPSQYzQxTVdpfxz29_wLtfx6kJ2s7oy0CbPuu2bgUdPFDptnfr5uc0HF5Y2EaVocDr0EJe-HTTSSkArUTTT6cb53aaFC5bXBPzG6XXjDdyPhXDP9gkioVrRJuPd8zeuaIPPqRmhUJpElKOCY1Wlhn64cMwKT9EdT4L8L3p7zMTs7R_JoL91Rer6pjwaVRdojHf5N7aebB29acanqdjpzVkMFIoLMtYDcuPrGEpLrYVurmmZ8DHBl2Oy5OquEKfureBhBaf1y19FvfSjsNlYP9aN2nudTWF5OTL3b3rxcmFK-XWl0mIEUh8AZqzfcAIAn5Hg_MDMVKIx67ojkmPpUoXF2pcgrKTZKed3pmla9O-xoOUmATQuny0VKBQKtQ_hG6XQmB12BltXY_vi6A9mveWd55ovHM-DpoZKgAAzP4FS4GekTCudhxrCVMO0',
        },
      );
      var responseBody = json.decode(response.body);
      print(responseBody);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        return responseBody["data"];
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      print(e.toString());
      throw Exception("Something went wrong");
    }
  }
}
