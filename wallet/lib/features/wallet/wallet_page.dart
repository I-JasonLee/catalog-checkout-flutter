import 'package:flutter/material.dart';
import '../../services/deeplink_service.dart';

import 'pin_dialog.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final DeeplinkService _deeplinkService = DeeplinkService();

  String status = "Menunggu transaksi...";
  String amount = "0";
  String transactionId = "-";

  @override
  void initState() {
    super.initState();

    _deeplinkService.init((uri) {
      if (!mounted) return;

      setState(() {
        amount = uri.queryParameters['amount'] ?? "0";
        transactionId = uri.queryParameters['transactionId'] ?? "-";
        status = "Menerima pembayaran dari Merchant";
      });

      _showPaymentDialog();
    });
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment Request"),
        content: Text(
          "Bayar Rp $amount untuk transaksi $transactionId ?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              setState(() {
                status = "Pembayaran berhasil ✅";
              });
            },
            child: const Text("Bayar"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _deeplinkService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "E-Money Wallet",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Text("Status: $status"),
            const SizedBox(height: 10),

            Text("Amount: Rp $amount"),
            Text("Transaction ID: $transactionId"),
          ],
        ),
      ),
    );
  }
}