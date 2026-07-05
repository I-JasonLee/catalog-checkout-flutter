import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  static const String baseUrl = "http://10.0.2.2:3000";

  Future<List<dynamic>> fetchProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");

    // 🔍 DEBUG TOKEN
    print("JWT TOKEN:");
    print(token);

    if (token == null || token.isEmpty) {
      throw Exception("JWT kosong, user belum login atau belum disimpan");
    }

    final response = await http.get(
      Uri.parse("$baseUrl/products"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["data"];
    } else {
      throw Exception("Gagal ambil products: ${response.body}");
    }
  }
}