import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/cart_provider.dart';
import '../../auth/provider/auth_provider.dart';

Future<void> openWalletPayment(
    int amount,
    String token,
) async {


  final uri = Uri.parse(
    "wallet://payment"
    "?amount=$amount"
    "&transactionId=123"
    "&token=$token",
  );


  final success = await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );


  if(!success){

    print(
      "Gagal membuka Wallet",
    );

  }

}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? const Center(child: Text("Cart kosong"))
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];

                      return ListTile(
                        title: Text(item["name"]),
                        subtitle: Text("Rp ${item["price"]}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            cart.removeFromCart(item);
                          },
                        ),
                      );
                    },
                  ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Total: Rp ${cart.totalPrice}",
                  style: const TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {


  final auth =
  Provider.of<AuthProvider>(
    context,
    listen:false,
  );


  if(auth.jwtToken != null){

    print("JWT DI CART:");
print(auth.jwtToken);

    openWalletPayment(
      cart.totalPrice,
      auth.jwtToken!,
    );


  }
  else{

    print(
      "JWT belum tersedia"
    );

  }


},
                  child: const Text("Bayar dengan Wallet"),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: cart.items.isEmpty
                      ? null
                      : () {
                          cart.clearCart();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Checkout Success 🎉"),
                            ),
                          );

                          Navigator.pop(context);
                        },
                  child: const Text("Checkout"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}