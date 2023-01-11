import 'dart:convert';

import 'package:dio/dio.dart';

class ApiServices{
  static String baseUrl = "https://confess-features-suggestions-website-m3qj.vercel.app/suggestions";

  static void sendSuggestion({required String suggestion}) async{
    final Dio dio = Dio();
    final data = {
      "body": suggestion,
    };
    final String jsonString = jsonEncode(data);

    try{
      var response = await dio.post(baseUrl, data: jsonString,);
      if(response.statusCode == 200){
        print('Success!');
      } else{
        print('Failed!');
      }
    } on DioError catch(e){
      print(e);
    }
  }
}