import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/product_dummy.dart';
import '../model/product_model.dart';
import '../../cart/provider/cart_provider.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = ProductDummy.products;
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog"),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return ListTile(
            title: Text(product.name),
            subtitle: Text("Rp ${product.price}"),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                cart.addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${product.name} added")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}