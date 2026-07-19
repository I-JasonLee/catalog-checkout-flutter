import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/wallet/wallet_page.dart';
import 'features/wallet/provider/wallet_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = WalletProvider();
            provider.loadBalance();
            provider.loadHistory();
            return provider;
          }
        ),
      ],
      child: const WalletApp(),
    )
  );
}

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wallet App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WalletPage(),
    );
  }
}

// Reset Saldo : adb shell pm clear com.example.wallet