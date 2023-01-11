import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static String baseUrl =
      "https://confess-features-suggestions-website-m3qj.vercel.app/suggestions";

  // static String baseUrl = "http://localhost:3000/suggestions";

  static void sendSuggestion({required String suggestion}) async {
    final data = {
      "body": suggestion
    };
    final String jsonString = jsonEncode(data);

    print(jsonString);

    try {
      http.Response response = await http.post(
        Uri.parse(baseUrl),
        body: jsonString,
        headers: {
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        print('Success!');
        print(suggestion);
      } else {
        print('Failed!');
      }
    } catch (e) {
      print(e);
    }
  }
}
