import 'package:flutter/material.dart';

import '../data/product_dummy.dart';
import '../model/product_model.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products = ProductDummy.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog Product"),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              title: Text(product.name),
              subtitle: Text("Rp ${product.price}"),
              trailing: const Icon(Icons.add_shopping_cart),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${product.name} dipilih"),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}