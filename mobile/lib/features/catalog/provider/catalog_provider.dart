import 'package:flutter/material.dart';
import '../../../core/api/product_service.dart';

class CatalogProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<dynamic> products = [];
  bool isLoading = false;

  Future<void> loadProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      products = await _service.fetchProducts();
    } catch (e) {
      print("ERROR: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}