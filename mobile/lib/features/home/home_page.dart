import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../catalog/presentation/catalog_page.dart';
import '../cart/presentation/cart_page.dart';
import '../auth/presentation/login_page.dart';
import '../cart/provider/cart_provider.dart';
import '../../../services/merchant_deeplink_service.dart';
import '../transaction/presentation/transaction_page.dart';
import '../transaction/provider/transaction_provider.dart';
import '../transaction/model/transaction_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MerchantDeeplinkService _deeplinkService =
      MerchantDeeplinkService();

  @override
void initState() {
  super.initState();
  Future.microtask(() async {
    await _deeplinkService.init((uri) {
      print("=== CALLBACK ===");
      print(uri.toString());
      if (uri.scheme == "merchant" &&
          uri.host == "payment-result") {
        print("CALLBACK DITERIMA");
        final status =
            uri.queryParameters["status"] ?? "failed";
        final transactionId =
            uri.queryParameters["transactionId"] ?? "-";
        final amount =
            int.parse(
              uri.queryParameters["amount"] ?? "0",
            );
        print(status);
        print(transactionId);
        print(amount);
        Provider.of<TransactionProvider>(
          context,
          listen: false,
        ).addTransaction(
          TransactionModel(
            transactionId: transactionId,
            amount: amount,
            status: status,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              status == "success"
              ? "✅ Pembayaran Berhasil\nTransaction ID : $transactionId"
              : "❌ Pembayaran Gagal\nTransaction ID : $transactionId",
            ),
          ),
        );
      }
    });
  });
}

  @override
  void dispose() {
    _deeplinkService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CartPage(),
                    ),
                  );
                },
              ),
              if (cart.items.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.items.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CatalogPage(),
                  ),
                );
              },
              child: const Text("Go to Catalog"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TransactionPage(),
                  ),
                );
              },
              child: const Text("Status Transaksi"),
            ),

          ],
        ),
      ),
    );
  }
}