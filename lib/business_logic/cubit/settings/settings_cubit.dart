

// import 'dart:convert';

// // import 'package:book/busines-logic/state.dart';

// import 'package:book_nook_user/services/storage/store.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';

// part of 'settings_state.dart';

// class EdaitadressCubit extends Cubit<EdaitAdressState> {
//  EdaitadressCubit() : super(EdaitInitialState());

//   static EdaitadressCubit get(context) => BlocProvider.of(context);



//     Future getEdetAdress(
      
//       {required String Title,
//       required String Area,
//       required String street,
//         required String Floor,
//         required String Near,
//         required String Details,
//       }) async {

//     try {print("hiii");
//       // var response = await http.get(url);
//       Map<String, String> body = {
//         "Title": Title,
//         "Area": Area,
//         "Florr": Floor,
//         "Near": Near,
//         "Details": Details,

//       };
//     print("rama");
//            Response response =await http.put(Uri.parse("${Store.baseURL}/api/address/1"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjU3ZDUzY2NhNzcxMjQ5OTRiOGM3ODNhMzE0NmZjNjlmYmE5OWU1NjYwYzBhNzIyMjY5NWQxNmQyNTE0NWZhYzhkN2VkODlkNWIyNDBhMTEiLCJpYXQiOjE2NjAyMTQyMjIuMjM3NTQsIm5iZiI6MTY2MDIxNDIyMi4yMzc1NDMsImV4cCI6MTY5MTc1MDIyMi4yMDY4LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.SZ4rL2V6JLqhdTmsvumSn8eN523bOrboHb0vAhfj8V1bplx8PARCaWQR0Ryc_8yEE3l9tTo-jXUHxB_LAoWUf-nlHF55UGlqZMw6ydPbgxpJHdIhDifkVEAtHxoWshWWsNGDldxQA7aJbkx3Y1EjE8Z49OCDjifMtjS5avkSoX3cO0eLtsoj3UOXnbH5BbUKNPG8Fefh7kxJYdp0YbXySiHW_-WRFJA2oyBkD20W3NLQIvSGFYuKSVkIhYcTtmNu8CWj8UAO6fyaTunFFRFuKlIVOSH0lyS7f8LWf8X-H9oXm0b0AvEHEVV_OphHERxA_i-8hpR4ger7nTd3aMIeOYpmXud2PAlW3tI16OcBpk0sg_Sl5Lr7eH__zkfDdIIwYKpQri56Zt-r6ry2pELs7Ofl7JgnQZZ_1uF630gt8J_XJ-iVRhYEDqDKRMl9rBITE0olY-ZP772Bj6h0W3RFeWDiw9ho830ljcdkZGYjAr4oomJg-F_LvzxJdGEk_91EkE6Iu2-mg9DWpDqC9YI3ghR6SW4LVo9WpPhmNq_ls2_dbKhPbhc-pVGZYaoVRgnOChEw2UEKUkEu0_52cPcYfl4CI1cr2jZExuyftg9tkBN0NPYfa58xXGuwBH0464PsRbvEWWh-T_vLXHWLtbiBlg_gZzMVsYm55TKJx2DKYrY'
//                },
//               body: body);
    
//       print("hala");
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//   }

//     Future getEdetadminprofile(
//       {
//       required String first_name ,
//         required String middle_name,
//         required String last_name,
//         required String library_name,
//          required String phone_number,
//           required String status,
//           required String open_time,
//             required String close_time,
          
//       }) async {
       
//     try {print("hiii");
//       // var response = await http.get(url);
//       Map<String, String> body = {
       
       
//         "first_name": first_name,
//         "middle_name": middle_name,
//         "library_name": library_name,
//         "last_name": last_name,
//         "phone_number": phone_number,
//         "status": status,
//         "open_time": open_time,
//          "close_time": close_time,
         

//       };
    
     
//     print("rama");
//            Response response =await http.put(Uri.parse("${Store.baseURL}/api/information/admin/"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNDkzY2RjYTc1YmVjNjAyODI1NzdmYzA5NmJlNzBiMjU5ZDI3NjUxNTMzMzkwNTcyODM1OWRkZjAxNGJhMzkyZDA4MzRmMzdkMzVhZWIyNWMiLCJpYXQiOjE2NjAxNTUwOTUuNzMyMTE1LCJuYmYiOjE2NjAxNTUwOTUuNzMyMTIsImV4cCI6MTY5MTY5MTA5NS43MTU0MTEsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.cQDrzs7TGMUWX2bzJTlXMJEJ5ffWd7bG2ebaEnhp-meuMHqv1QaeZU3p3SjcEGPCyXpbvDZf2tPXvVor9QBvRQXJ-XFg59oAC-OwgpzFclV0l3nOkce75OfFb_RPrhaD9zGq1J4HzeORb4iwKOs_msRSkRhnYWxTGY8Tc65pzC1risdWYyjz_fmgoEad64ReieIe149QiY8_jwOmM9_3-_wlYErca8TnY-5nZEBQvCyQh0wYEt2g6XFmy1h14Jfs5Uklw1te5gUJvzMebxGXWwuWoOfVEym6OlNkaj-2LB_DfI2WEKsWCGbkN2bKHP6WWnaw5ivojQLvM71SxylYrHrxi60mbLl-F2MF2G5mqr9bZKfXOEcKBEtTKW25LM_ktNcikbm7_3dqY2XjEZ0nJm-seoelWW1cRrR8S8_DvkIdRsVhRUGqXPxT-RmW6RodvNTBD8Bc6JdLygjely26J6plMu6XBfVSUadsZfLNKXtqxMZH_rMYOqN8SDiL9bLVugZQcE62AMAM5ckkgWFoRo0YiY4TKvTMsJ9nC_0QcmxPCJz7YF9zFahgBwN4YAYTRA9J98vPsr25WNeB6JR_NT_ySzQdEetpaDwQD6V35VO17dH_qOSKdSyIsUStQ-vzV7Q-XBW18gXw25YEmkA8TflKKb3qmhbyu2JmQVlIAMQ'
//                },
//               body: body);
    
//       print("hala");
//       print(response.body);
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//       }
    
//     Future getEdetuserprofile(
      
//       {                                                           
    
//       required String first_name ,
//         required String middle_name,
//         required String last_name,
//        required String gender,
//          required String phone_number,
//           required String birth_day,
          
//       }) async {
       
//     try {print("hiii");
//       // var response = await http.get(url);
//       Map<String, String> body = {
//         "first_name": first_name,
//         "middle_name": middle_name,
//         "last_name": last_name,
//         "gender": gender,
//         "phone": phone_number,
//         "birth_day": birth_day,
       

//       };
    
     
//     print("rama");
//            Response response =await http.put(Uri.parse("${Store.baseURL}/api/information/customer/"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':' Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjBmNjVmNzExZjg5NmFlNGNkMzY4NjUwOGFmZTc5YjgxYTYxZWYyZmY3NGU4ZjBkNjM0NDZkMjM2OTY3MDk5ZDFkODY1OTNjYmQyMzlhYzkiLCJpYXQiOjE2NjAyMDYwNzkuNjU0OTg1LCJuYmYiOjE2NjAyMDYwNzkuNjU0OTg3LCJleHAiOjE2OTE3NDIwNzkuNjQ4MTYsInN1YiI6IjIiLCJzY29wZXMiOltdfQ.PbumMhAflt4cmX5X6cEA1XRm0DcYspr2ETOdXINekHwr7K9-tpzvl8b52eAWeF1IV_sgcNGJmIF4NsLlOKhPq3V1GmEUY-scL3roRAjPfScZ0WbDFm7YyJTPns6a3YXwJl9009zF7a1A7chsr-fOC3B7OzQ6cqQSWrxMmMj8Sm5FYs94JenFdrE3jRROCxVeTnsn7asG4LYSTBZzYwgJNTaq_dSHf2COBd-UMja6ajPWzWuIkBQPmdqDFRz_rmReae7L7co_wBf8L4GUMWjhgohZvGCnvEeKEu8Lx1c76l93M8PrWMNXE4BwdqHU4JsYYnCL7tkt-VNEihiPTZjmkATyjxBCTZ89osb_6Y7c_5vNHcYzPXrIutYATSKOLUc6KJP--C83aAJ1iSkoqUMR5tHhEl6rzJR9PqrMkoLj6bEUVBrdTrsu77OznTDP9pWHQmMcWzyRVDCGCSNlpgfLRYk17LAVkNkn35h2eyNbGNwADGDANsDCiE4NjODey7PylnhZAlwPB1cI83CK90wGfJat-cjdLfNEbBC2TBauB-s0iN1dl6HI0VyH9CuCUS5S719vD2Uy-si0sJVVNSLbfgmOfT7tS-Bk_ts0fwyv38BqtxWJ9H4SSuEnHBnNEvcHgvMknMh0fmvUWyrZsnlH8Ohdh-duZ1nor61JXLeMI1o'
//                },
//               body: body);
    
//       print("hala");
      
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//       }
      
//     Future deletbook(
      
//      ) async {
       
//     try {print("hiii");
//       // var response = await http.get(url);
     
    
     
//     print("rama");
//            Response response =await http.delete(Uri.parse("${Store.baseURL}/api/book/2"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':' Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYWViZTExODIxODgzYTkzZDVhNWY2OWE3YTc4OWVlMjdhZTUwN2JmMjBmNzFmZjE2MjIzNjdjMmIwODhlNGJhMTY3MDc5ZGU2NzMyMmZiYzAiLCJpYXQiOjE2NjAyMTAyNTcuMTQ5MzAxLCJuYmYiOjE2NjAyMTAyNTcuMTQ5MzA0LCJleHAiOjE2OTE3NDYyNTcuMTM5ODg1LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.wQiFsnH-ExqaZ4wz-mOpKgLI8gRbw006vIbnHWAUtAoxgc7m9w6VT9IEpw2LkGS6ElBTBK3-S5n6jblcV2OFN4M1cjl0G8Zualo1lI4j2HwZEUM426Pn1YhddFsYFK2lhzGqVHiHelQZKCtUT2c-3lG01u4xzoKXq9pqTBYJ5A2wkx-8l2oUak4C46cGQxYYgI6vr_rOzL-2WwO2z3i0Djho3sGY_UzCunLA6nWVNw7TiRBuUhPAuo2MAdOrQdJeg6OTuaiXzloQUKwo3EcOUTDa1Q8PELPhSBMSBvbISesW8nr7c90xQBcafVmSku1oLlviMMbh1BC7OsrrcWt62iHZrtsdGExt_roRZhfNqdx6iOzKDCt9ZaoY92FMKaMS5u24Ka0WgKNm8sTqaf3b5r1EUE8PQ2KLRLslXSu9nvAnjvUdu7QOA7iWig-z4u-DPZrHUs7FSz4wTZgcGnwVxtqHE9VlmAJyQuTnds4XMTXjhynOEKorFvFB82LvjAUDyNuD1Yt3dKDEd7PkBqLVuSAncYJZ39pPk8ygsFMvQem0yDa5z4XgVVQp77yP2vQWu5MgHBWz8odpuceVUuYybs1twV_rSHjYEP3AKOTU-zRRA5s7PgmJmy-EXw9-C82BcsgkdYTzRAPFwyO8qCtbYd3Bq1H3znlQALhyn2p-Sms'},
//               );
    
//       print("hala");
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//       }
      
//     Future getRate(
      
//       {                                                           
//           required String star,
          
//       }) async {
       
//     try {print("hiii");
//       Map<String, String> body = {
        
//         "star": star,
       

//       };
    
     
//     print("rama");
//            Response response =await http.post(Uri.parse("${Store.baseURL}/api/book/rate/3"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':' Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjU3ZDUzY2NhNzcxMjQ5OTRiOGM3ODNhMzE0NmZjNjlmYmE5OWU1NjYwYzBhNzIyMjY5NWQxNmQyNTE0NWZhYzhkN2VkODlkNWIyNDBhMTEiLCJpYXQiOjE2NjAyMTQyMjIuMjM3NTQsIm5iZiI6MTY2MDIxNDIyMi4yMzc1NDMsImV4cCI6MTY5MTc1MDIyMi4yMDY4LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.SZ4rL2V6JLqhdTmsvumSn8eN523bOrboHb0vAhfj8V1bplx8PARCaWQR0Ryc_8yEE3l9tTo-jXUHxB_LAoWUf-nlHF55UGlqZMw6ydPbgxpJHdIhDifkVEAtHxoWshWWsNGDldxQA7aJbkx3Y1EjE8Z49OCDjifMtjS5avkSoX3cO0eLtsoj3UOXnbH5BbUKNPG8Fefh7kxJYdp0YbXySiHW_-WRFJA2oyBkD20W3NLQIvSGFYuKSVkIhYcTtmNu8CWj8UAO6fyaTunFFRFuKlIVOSH0lyS7f8LWf8X-H9oXm0b0AvEHEVV_OphHERxA_i-8hpR4ger7nTd3aMIeOYpmXud2PAlW3tI16OcBpk0sg_Sl5Lr7eH__zkfDdIIwYKpQri56Zt-r6ry2pELs7Ofl7JgnQZZ_1uF630gt8J_XJ-iVRhYEDqDKRMl9rBITE0olY-ZP772Bj6h0W3RFeWDiw9ho830ljcdkZGYjAr4oomJg-F_LvzxJdGEk_91EkE6Iu2-mg9DWpDqC9YI3ghR6SW4LVo9WpPhmNq_ls2_dbKhPbhc-pVGZYaoVRgnOChEw2UEKUkEu0_52cPcYfl4CI1cr2jZExuyftg9tkBN0NPYfa58xXGuwBH0464PsRbvEWWh-T_vLXHWLtbiBlg_gZzMVsYm55TKJx2DKYrY'
//                },
//               body: {
//                 "star":star
//               });
    
//       print("hala");
     
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//       }
//        Future savebook(
      
    
          
//       ) async {
       
//     try {print("hiii");
//       // var response = await http.get(url);
   
    
     
//     print("rama");
//            Response response =await http.post(Uri.parse("${Store.baseURL}/api/save/3"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':' Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjU3ZDUzY2NhNzcxMjQ5OTRiOGM3ODNhMzE0NmZjNjlmYmE5OWU1NjYwYzBhNzIyMjY5NWQxNmQyNTE0NWZhYzhkN2VkODlkNWIyNDBhMTEiLCJpYXQiOjE2NjAyMTQyMjIuMjM3NTQsIm5iZiI6MTY2MDIxNDIyMi4yMzc1NDMsImV4cCI6MTY5MTc1MDIyMi4yMDY4LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.SZ4rL2V6JLqhdTmsvumSn8eN523bOrboHb0vAhfj8V1bplx8PARCaWQR0Ryc_8yEE3l9tTo-jXUHxB_LAoWUf-nlHF55UGlqZMw6ydPbgxpJHdIhDifkVEAtHxoWshWWsNGDldxQA7aJbkx3Y1EjE8Z49OCDjifMtjS5avkSoX3cO0eLtsoj3UOXnbH5BbUKNPG8Fefh7kxJYdp0YbXySiHW_-WRFJA2oyBkD20W3NLQIvSGFYuKSVkIhYcTtmNu8CWj8UAO6fyaTunFFRFuKlIVOSH0lyS7f8LWf8X-H9oXm0b0AvEHEVV_OphHERxA_i-8hpR4ger7nTd3aMIeOYpmXud2PAlW3tI16OcBpk0sg_Sl5Lr7eH__zkfDdIIwYKpQri56Zt-r6ry2pELs7Ofl7JgnQZZ_1uF630gt8J_XJ-iVRhYEDqDKRMl9rBITE0olY-ZP772Bj6h0W3RFeWDiw9ho830ljcdkZGYjAr4oomJg-F_LvzxJdGEk_91EkE6Iu2-mg9DWpDqC9YI3ghR6SW4LVo9WpPhmNq_ls2_dbKhPbhc-pVGZYaoVRgnOChEw2UEKUkEu0_52cPcYfl4CI1cr2jZExuyftg9tkBN0NPYfa58xXGuwBH0464PsRbvEWWh-T_vLXHWLtbiBlg_gZzMVsYm55TKJx2DKYrY'
//                },
//             );
    
//       print("hala");
     
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//       }
//       Future deletoffer(
      
//      ) async {
       
//     try {print("hiii");
//     print("rama");
//            Response response =await http.delete(Uri.parse("${Store.baseURL}/api/offer/2"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':' Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjU3ZDUzY2NhNzcxMjQ5OTRiOGM3ODNhMzE0NmZjNjlmYmE5OWU1NjYwYzBhNzIyMjY5NWQxNmQyNTE0NWZhYzhkN2VkODlkNWIyNDBhMTEiLCJpYXQiOjE2NjAyMTQyMjIuMjM3NTQsIm5iZiI6MTY2MDIxNDIyMi4yMzc1NDMsImV4cCI6MTY5MTc1MDIyMi4yMDY4LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.SZ4rL2V6JLqhdTmsvumSn8eN523bOrboHb0vAhfj8V1bplx8PARCaWQR0Ryc_8yEE3l9tTo-jXUHxB_LAoWUf-nlHF55UGlqZMw6ydPbgxpJHdIhDifkVEAtHxoWshWWsNGDldxQA7aJbkx3Y1EjE8Z49OCDjifMtjS5avkSoX3cO0eLtsoj3UOXnbH5BbUKNPG8Fefh7kxJYdp0YbXySiHW_-WRFJA2oyBkD20W3NLQIvSGFYuKSVkIhYcTtmNu8CWj8UAO6fyaTunFFRFuKlIVOSH0lyS7f8LWf8X-H9oXm0b0AvEHEVV_OphHERxA_i-8hpR4ger7nTd3aMIeOYpmXud2PAlW3tI16OcBpk0sg_Sl5Lr7eH__zkfDdIIwYKpQri56Zt-r6ry2pELs7Ofl7JgnQZZ_1uF630gt8J_XJ-iVRhYEDqDKRMl9rBITE0olY-ZP772Bj6h0W3RFeWDiw9ho830ljcdkZGYjAr4oomJg-F_LvzxJdGEk_91EkE6Iu2-mg9DWpDqC9YI3ghR6SW4LVo9WpPhmNq_ls2_dbKhPbhc-pVGZYaoVRgnOChEw2UEKUkEu0_52cPcYfl4CI1cr2jZExuyftg9tkBN0NPYfa58xXGuwBH0464PsRbvEWWh-T_vLXHWLtbiBlg_gZzMVsYm55TKJx2DKYrY'},
//               );
    
//       print("hala");
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//       }
      

//     Future edaitbook(
      
//       {
//       required String Name ,
//         required String Summary,
//         required String Page_number,
//         required String Purchasing_price,
//          required String Selling_price,
//           required String Quantity,
//           required String Authors,
//             required String Category,
          
//       }) async {
       
//     try {print("hiii");
//       // var response = await http.get(url);
//       Map<String, String> body = {
       
       
//         "Name": Name,
//         "Summary": Summary,
//         "Page_number": Page_number,
//         "Purchasing_price": Purchasing_price,
//         "Selling_price": Selling_price,
//         "Quantity": Quantity,
//          "Authors": Authors,
//          "Category": Category,
//       };
//     print("rama");
//            Response response =await http.put(Uri.parse("${Store.baseURL}/api/book/4"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjc0MjhlZGU0NzU0MTZiZjNmZWVhMDg1ZGI1ODI3NmM4ZDA1NTNjY2M2MzVjZGFjODNiMzA3YWI0YjI4NjU0NjcwNzc3M2NlOTQzNGM1MzYiLCJpYXQiOjE2NjAyMzY2MzkuNTQyMDI1LCJuYmYiOjE2NjAyMzY2MzkuNTQyMDI4LCJleHAiOjE2OTE3NzI2MzkuNTM3MTE4LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.O7crv2SHMAVKAD6N0PYATrb-EQG_he9_RyGUV4AhPlcHIj_xJEqt11ELZLMnNHrQ04A4aHUTC7JB0mWrkhlNJdOcUuAo8TPWdWwKZzmqqRsU0vK_6JqfAaghRFCIWePTItip-GOpAe8VlqNT_ORXz2hNX0rTVvYvMJ64_6txMYUvxIutnwY0C9aYgUTkQjtLenzoNpXu0wUz4mGe0kYT9X3UmtokaG2dAiAFPED07A2qk8VOd79mHHbmfEDD51ny3ZsrzdeRPbsMQZ_CCQAEh2E6hS27IoUuazyCB5R3Lf13_kUE0hFsGi7Z_FK7DCqs7nzs6QVceir7xl163ATcrboeO8BaX1X5VPt1QN5RoEgik4fl2dj-sajeR_dF0VuUHd-2OACiVL6W_e6SG_x1TrEmGe-FfSqtw6uk8UYFf1Qf4bweLIQU4NQ6eX_rXHD41YKEkLvhInvviXuTxCjPndW1U5p2ku4zpGLkTrGveP2xI2kByQAx_mPM_JBqzAGOK-_jgUKIohx6hXIlC8yeaaNTx2xaUO_iJK1WvCaa5VFSiB8J8746i-cHP2a0meZBL8PFF-siv76yLbjRYaNVrB9K2U2VSk-b_1KGG-f34XeRgDwLS2k0M4Km1B6bcpmeUmfQPxptd4O19vW076N6QV03WkA-jRrlzTkwP26KmcU'
//                },
//               body: body);
    
//       print("hala");
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//       }

      
//       Future deletComent(
      
//      ) async {
       
//     try {print("hiii");
//     print("rama");
//            Response response =await http.delete(Uri.parse("${Store.baseURL}/api/comment/2"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':' Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWJhMzc3ZTQ2Y2M1NzA4NGMwYzRmMDY4OWFkN2NlZTE3ZDFlNDgyNzc1OGVmODk5ODM1ODk1MjIzZjUzM2YwZjMzNGI1YWU1YjI0YzgzZTQiLCJpYXQiOjE2NjAzMDM3NjkuMDQxODk1LCJuYmYiOjE2NjAzMDM3NjkuMDQxOTAyLCJleHAiOjE2OTE4Mzk3NjkuMDA4NDc2LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.ebXUOHSsyfVMj9EQqx18vLax3tydnfuNLh7FTu0EsLDLZsSVcNOtZ-pNM7i2V7uOyAPhkgYgJe9umicKhG0OiruhrRfJch_z6LgaHUIl1lp8AHLhO84NAAFdq8szOwFuD4OtIkJf3cRvnMtrkZeuvpBXpcz7FEu0dKeQb2MGLgqgFjP1zRE0Av8-7_8q0NLmazJM1STgZekT-22ecIBYiqR9sQ_hD29l7NTFmAk56iyUIklctENpMU1EaOWpv5HR5drz0SPMtVHYZjqlKSin7GEZR1yjnYol18Q8XbAVvSOmOyytG8nQ7SvrPBZn8Nvi1Evjo_9mgUsuUXMfW9Nn7V-wGSuzNnCHjIlrj2AS4TJuzcx4BOFHVfX0dOWHpbhL2hqXVFB0D-NqQ_KXvAoBRR5qPQs0DhAnQatgITusWjdUK4P_Ter6muws4uInjGDtkF0RPOy67gGKLZoVbZ7HXDjaiZk4NUkxhVBhbGyJhd9RX9fqtkrBO-j04mX9LalkoO05EFEVZabgPre0wYHqbSKVRqEZBFE93cE9rT2aZD1d2dNAVxdJOo2H8RHQc1AOZc4O-KjH7Ag8G23IxwjcrjiPlbwjGdmPVvbAmfQczk63XbbHCylYfRvhZGt9xDHMPlQ0VzNbh6NgUf3kjMN6zCFfW-hwiyZEPa5UmSlBwUU'
//                 },
//               );
    
//       print("hala");
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//       }
      
//       Future deletQuote(
      
//      ) async {
       
//     try {print("hiii");
//     print("rama");
//            Response response =await http.delete(Uri.parse("${Store.baseURL}/api/quote/2"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':' Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWJhMzc3ZTQ2Y2M1NzA4NGMwYzRmMDY4OWFkN2NlZTE3ZDFlNDgyNzc1OGVmODk5ODM1ODk1MjIzZjUzM2YwZjMzNGI1YWU1YjI0YzgzZTQiLCJpYXQiOjE2NjAzMDM3NjkuMDQxODk1LCJuYmYiOjE2NjAzMDM3NjkuMDQxOTAyLCJleHAiOjE2OTE4Mzk3NjkuMDA4NDc2LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.ebXUOHSsyfVMj9EQqx18vLax3tydnfuNLh7FTu0EsLDLZsSVcNOtZ-pNM7i2V7uOyAPhkgYgJe9umicKhG0OiruhrRfJch_z6LgaHUIl1lp8AHLhO84NAAFdq8szOwFuD4OtIkJf3cRvnMtrkZeuvpBXpcz7FEu0dKeQb2MGLgqgFjP1zRE0Av8-7_8q0NLmazJM1STgZekT-22ecIBYiqR9sQ_hD29l7NTFmAk56iyUIklctENpMU1EaOWpv5HR5drz0SPMtVHYZjqlKSin7GEZR1yjnYol18Q8XbAVvSOmOyytG8nQ7SvrPBZn8Nvi1Evjo_9mgUsuUXMfW9Nn7V-wGSuzNnCHjIlrj2AS4TJuzcx4BOFHVfX0dOWHpbhL2hqXVFB0D-NqQ_KXvAoBRR5qPQs0DhAnQatgITusWjdUK4P_Ter6muws4uInjGDtkF0RPOy67gGKLZoVbZ7HXDjaiZk4NUkxhVBhbGyJhd9RX9fqtkrBO-j04mX9LalkoO05EFEVZabgPre0wYHqbSKVRqEZBFE93cE9rT2aZD1d2dNAVxdJOo2H8RHQc1AOZc4O-KjH7Ag8G23IxwjcrjiPlbwjGdmPVvbAmfQczk63XbbHCylYfRvhZGt9xDHMPlQ0VzNbh6NgUf3kjMN6zCFfW-hwiyZEPa5UmSlBwUU'
//                 },
//               );
    
//       print("hala");
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//       }
//        Future UpdateComment(
      
//       {required String value,
     
//       }) async {

//     try {print("hiii");
//       // var response = await http.get(url);
//       Map<String, String> body = {
//         "value": value,
       

//       };
//     print("rama");
//            Response response =await http.put(Uri.parse("${Store.baseURL}/api/comment/3"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWJhMzc3ZTQ2Y2M1NzA4NGMwYzRmMDY4OWFkN2NlZTE3ZDFlNDgyNzc1OGVmODk5ODM1ODk1MjIzZjUzM2YwZjMzNGI1YWU1YjI0YzgzZTQiLCJpYXQiOjE2NjAzMDM3NjkuMDQxODk1LCJuYmYiOjE2NjAzMDM3NjkuMDQxOTAyLCJleHAiOjE2OTE4Mzk3NjkuMDA4NDc2LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.ebXUOHSsyfVMj9EQqx18vLax3tydnfuNLh7FTu0EsLDLZsSVcNOtZ-pNM7i2V7uOyAPhkgYgJe9umicKhG0OiruhrRfJch_z6LgaHUIl1lp8AHLhO84NAAFdq8szOwFuD4OtIkJf3cRvnMtrkZeuvpBXpcz7FEu0dKeQb2MGLgqgFjP1zRE0Av8-7_8q0NLmazJM1STgZekT-22ecIBYiqR9sQ_hD29l7NTFmAk56iyUIklctENpMU1EaOWpv5HR5drz0SPMtVHYZjqlKSin7GEZR1yjnYol18Q8XbAVvSOmOyytG8nQ7SvrPBZn8Nvi1Evjo_9mgUsuUXMfW9Nn7V-wGSuzNnCHjIlrj2AS4TJuzcx4BOFHVfX0dOWHpbhL2hqXVFB0D-NqQ_KXvAoBRR5qPQs0DhAnQatgITusWjdUK4P_Ter6muws4uInjGDtkF0RPOy67gGKLZoVbZ7HXDjaiZk4NUkxhVBhbGyJhd9RX9fqtkrBO-j04mX9LalkoO05EFEVZabgPre0wYHqbSKVRqEZBFE93cE9rT2aZD1d2dNAVxdJOo2H8RHQc1AOZc4O-KjH7Ag8G23IxwjcrjiPlbwjGdmPVvbAmfQczk63XbbHCylYfRvhZGt9xDHMPlQ0VzNbh6NgUf3kjMN6zCFfW-hwiyZEPa5UmSlBwUU'
//                },
//               body: body);
    
//       print("hala");
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//   }
//    Future UpdateQuote(
      
//       {required String value,
     
//       }) async {

//     try {print("hiii");
//       // var response = await http.get(url);
//       Map<String, String> body = {
//         "value": value,
//       };
//     print("rama");
//            Response response =await http.put(Uri.parse("${Store.baseURL}/api/quote/3"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWJhMzc3ZTQ2Y2M1NzA4NGMwYzRmMDY4OWFkN2NlZTE3ZDFlNDgyNzc1OGVmODk5ODM1ODk1MjIzZjUzM2YwZjMzNGI1YWU1YjI0YzgzZTQiLCJpYXQiOjE2NjAzMDM3NjkuMDQxODk1LCJuYmYiOjE2NjAzMDM3NjkuMDQxOTAyLCJleHAiOjE2OTE4Mzk3NjkuMDA4NDc2LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.ebXUOHSsyfVMj9EQqx18vLax3tydnfuNLh7FTu0EsLDLZsSVcNOtZ-pNM7i2V7uOyAPhkgYgJe9umicKhG0OiruhrRfJch_z6LgaHUIl1lp8AHLhO84NAAFdq8szOwFuD4OtIkJf3cRvnMtrkZeuvpBXpcz7FEu0dKeQb2MGLgqgFjP1zRE0Av8-7_8q0NLmazJM1STgZekT-22ecIBYiqR9sQ_hD29l7NTFmAk56iyUIklctENpMU1EaOWpv5HR5drz0SPMtVHYZjqlKSin7GEZR1yjnYol18Q8XbAVvSOmOyytG8nQ7SvrPBZn8Nvi1Evjo_9mgUsuUXMfW9Nn7V-wGSuzNnCHjIlrj2AS4TJuzcx4BOFHVfX0dOWHpbhL2hqXVFB0D-NqQ_KXvAoBRR5qPQs0DhAnQatgITusWjdUK4P_Ter6muws4uInjGDtkF0RPOy67gGKLZoVbZ7HXDjaiZk4NUkxhVBhbGyJhd9RX9fqtkrBO-j04mX9LalkoO05EFEVZabgPre0wYHqbSKVRqEZBFE93cE9rT2aZD1d2dNAVxdJOo2H8RHQc1AOZc4O-KjH7Ag8G23IxwjcrjiPlbwjGdmPVvbAmfQczk63XbbHCylYfRvhZGt9xDHMPlQ0VzNbh6NgUf3kjMN6zCFfW-hwiyZEPa5UmSlBwUU'
//                },
//               body: body);
    
//       print("hala");
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//   }

//  Future CancleOrder(
      
//      ) async {
       
//     try {print("hiii");
//     print("rama");
//            Response response =await http.post(Uri.parse("${Store.baseURL}/api/order/2/cancel_order"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization':' Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDFkZDM2OTllNGY0NGRjMmY5MGEzNjkxM2Y4ZWRkYTMwYWRmZWU5YmMxYzY0YzFkYWU3MzFkMjI0MWFiNDZjMDI4YjhhNWIzYjFkMzU5OWEiLCJpYXQiOjE2NjAzMTE0NDEuMzI2NzE4LCJuYmYiOjE2NjAzMTE0NDEuMzI2NzIyLCJleHAiOjE2OTE4NDc0NDEuMjg5NDY4LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Dx8qvB0271jIGSYjX2gzX2sH_ayrvWUy6n0I-2zq6l4N3nw-507EFkKkMvf3lviwL3t8AZ65BcCRPaVkqpN90MmpWPFSZHVGF2b4gTt5ChJUz119OxCJ_PG8F6DEgvXnSoBl8YS5ldZFVr86BzYIuSGO0AmcBA11kpqpfgRZ7CEwtLCmregPtcmz5iY3OqWccgbQD1LbDoSiaV_81do8lxl-c_eultWrwokBfOf3Q5s-v3crHrcQCTY4TbO-bVPy2m7O2H42ylENKTvpvLCJkm9HtN3lXzxlIzzScmZGs0_mOn7pBI-yE13xgO7Xu8PrDdskzZm_JkYqgX3-T-LjrfU2llPHPe5Pl-hMbGRDoce_yUeWTosE1br7WhJz43LD7sR1e_1kRfjlSMuT5wnK8jAAJQomX8DXMYczQTzIwiPxQrswIkZxtTHgKQ_4DCL7QWTrZfVVk3v5xFuSDzZKPe1K7ayKFzWHfjeyTPSm6m32-wCX3qte-NPSdA_Wfmz3qLVPryNiXOMuxR0Iq3-vFLjmOOfLw2D2pKA-_HbkUOTbFQzwXRKyh_yO-64HV_5fngSEMtRq2MCEchtIlAiL5q5d7bHLShYqI_ebg6l48SeL9ATigmfcP8P4vfcZlsIjtuq8dmvywZ1LYcCwdTWOE-ayzjE9dhr2LMRi6LF2u6c'
//                 },
//               );
    
//       print("hala");
//       print('Request success with status: ${response.statusCode}.');
//       if (response.statusCode == 200) {
//         // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         print("${jsonResponse['message']}");
       
//       } else {
      
//       }
//        } catch (e) {
//       print(e.toString());
//     }
//       }

//       }
