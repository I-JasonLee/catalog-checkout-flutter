import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addToCart(Map<String, dynamic> product) {
    _items.add(product);
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {_items.clear();
    notifyListeners();
  }

  int get totalPrice {
    return _items.fold(
      0,
      (sum, item) => sum + (item["price"] as int),
    );
  }
}