import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/catalog_provider.dart';

// import 'package:provider/provider.dart';
import '../../cart/provider/cart_provider.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CatalogProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CatalogProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog"),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                final item = provider.products[index];

                return Card(
                  child: ListTile(
                    title: Text(item["name"]),
                    subtitle: Text("Rp ${item["price"]}"),
                    trailing: const Icon(Icons.add_shopping_cart),
                    onTap: () {
                      context.read<CartProvider>().addToCart(item);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${item["name"]} ditambahkan"),
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