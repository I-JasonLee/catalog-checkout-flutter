import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/transaction_provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {

    final provider =
        Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Status Transaksi"),
      ),

      body: provider.transactions.isEmpty
          ? const Center(
              child: Text("Belum ada transaksi"),
            )
          : ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (context, index) {

                final trx =
                    provider.transactions[index];

                return ListTile(
                  leading: const Icon(Icons.payment),

                  title: Text(
                    "ID : ${trx.transactionId}",
                  ),

                  subtitle: Text(
                    "Rp ${trx.amount}",
                  ),

                  trailing: Text(
                    trx.status,
                  ),
                );
              },
            ),
    );
  }
}