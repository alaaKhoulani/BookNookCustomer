import 'package:bloc/bloc.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/ui/Screens/allLibrary/states.dart';
import 'package:book_nook_user/ui/Screens/search_user/sates.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AllLibraryCubit extends Cubit<AllLibraryStates> {
  AllLibraryCubit() : super(initial());
  static AllLibraryCubit get(context) => BlocProvider.of(context);
  List allLibApi = [];
  
  void getData() async {
    emit(initial());
    await getAllLibraryApi();
    emit(GetData());
  }

  Future getAllLibraryApi() async {
    try {
      log('inside getAllLibraryApi');
      var response = await http.get(
        Uri.parse("${Store.baseURL}/api/about/library/all"),
        headers: {
          'Accept': 'application/json',
          // 'Authorization':
          //     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzlkZTA5Y2JjYmFjOWVhYTEzMDYzYzRiZmJiMTk5MmYzYzA4ZTU2ZDFhNjA4Y2VmZjNkYTk5NzRkNTkwMzE3MDIzMTBkZWE2ZmNkNmIxNzUiLCJpYXQiOjE2NjAyMTU4MjYuMDI0NTUsIm5iZiI6MTY2MDIxNTgyNi4wMjQ1NywiZXhwIjoxNjkxNzUxODI1Ljg5NTg4Nywic3ViIjoiMiIsInNjb3BlcyI6W119.HPPx28I4K1FCZbLJzKawCEUU-nxgzAsejn19zvFw5g543JOYSE1GNqKadZkmg0hr4eycuVytNPh8se8OpR-xah3JTAbTyR1LOE_FHwDJgMGb1WrXgQv3vI75tYBzP9GCObEuhGHxmTdfOr6HZYkV3YJkgb23fMQkgT-TPDeU0eNiahYm-moIGHV1xGSO1a-F3lxNIi98aS4AkIWmtPXiIUkGrYBVvaVoAZ5UGuoGal5CEBryGvhiNEa5C7KwCZ580eEf-vmInOuCb-MalSNwUFjRtA-Z5_xxTyJbLXzA8A1VPUWFyRX6nE6kY56GqfmOCVnsZirnlZfvxD5G7xzerKOWQhgCgmwYg9YXIdjpoUXo6AKlGkIgHbcKKTh293B1ZPDkKHFFshjmpreOAcuASvVG-pfej9Ulmbl_YfPELDGgzgfTtm67cC14gr89QMSdEPRIgKcKoLEk-YebmN0fBk1ZGPPkE0nfHcl8Zcp-cFHhm-S6_pk1g4OgcMr2dqMLlNDL5J1CtYEyclRNw8dTZ18eAp-ZssEqWv0ElgL0Rry2FOoQbBbLz5ygIh35VVqT2o7kx27NHV_87ojphr8JUOLw8wvNKOx17bzwzRrPtu-0S6WOByJU7uv6l_5MI5BIekh8t7oXY7EK6a0UL2Cr4_f6zWK1-QA2v0EKQAtdqfI'
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        log('Request success with status: ${response.statusCode}.');
        log('${jsonResponse['data']}');
        allLibApi = jsonResponse['data'];
        // getData();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
