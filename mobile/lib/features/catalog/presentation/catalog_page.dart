import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../cart/provider/cart_provider.dart';
import '../model/product_model.dart';

class CatalogPage extends StatelessWidget {
  CatalogPage({super.key});

  final List<ProductModel> products = [
    ProductModel(id: "1", name: "Mouse Gaming", price: 150000),
    ProductModel(id: "2", name: "Keyboard Mechanical", price: 350000),
    ProductModel(id: "3", name: "Headset", price: 200000),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog"),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];

          return Card(
            child: ListTile(
              title: Text(item.name),
              subtitle: Text("Rp ${item.price}"),
              trailing: ElevatedButton(
                onPressed: () {
                  cart.addToCart(item);
                },
                child: const Text("Add"),
              ),
            ),
          );
        },
      ),
    );
  }
}