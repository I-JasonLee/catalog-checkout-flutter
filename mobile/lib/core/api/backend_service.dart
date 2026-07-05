import 'dart:convert';

import 'package:http/http.dart' as http;

class BackendService {
  // Android Emulator
  static const String baseUrl = "http://10.0.2.2:3000";

  // Jika pakai HP fisik:
  // static const String baseUrl = "http://IP_KOMPUTER:3000";

  Future<String> loginToBackend(String firebaseToken) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "token": firebaseToken,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data["jwt"];
    } else {
      throw Exception("Login backend gagal: ${response.body}");
    }
  }
}