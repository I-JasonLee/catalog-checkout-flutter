import 'package:flutter/material.dart';
import 'features/wallet/wallet_page.dart';

void main() {
  runApp(const WalletApp());
}

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wallet App",
      home: const WalletPage(),
    );
  }
}