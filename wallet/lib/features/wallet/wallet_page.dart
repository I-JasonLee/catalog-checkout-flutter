import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/wallet_provider.dart';


class WalletPage extends StatelessWidget {

  const WalletPage({super.key});


  @override
  Widget build(BuildContext context) {


    final wallet = Provider.of<WalletProvider>(context);


    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "E-Money Wallet",
        ),
      ),


      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,


          children: [


            const Text(
              "Saldo Wallet",
              style: TextStyle(
                fontSize: 18,
              ),
            ),


            const SizedBox(height: 10),



            Text(

              "Rp ${wallet.balance}",

              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),

            ),



            const SizedBox(height: 40),



            const Text(

              "Status Transaksi",

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),

            ),



            const SizedBox(height: 10),



            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(16),


              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(12),

                color: Colors.grey.shade200,

              ),


              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,


                children: [


                  Text(

                    wallet.transaction == null

                        ? "Menunggu Transaksi"

                        : wallet.transaction!.status,

                  ),



                  const SizedBox(height: 10),



                  Text(

                    wallet.transaction == null

                        ? "Amount: Rp 0"

                        : "Amount: Rp ${wallet.transaction!.amount}",

                  ),



                  const SizedBox(height: 10),



                  Text(

                    wallet.transaction == null

                        ? "Transaction ID: -"

                        : "Transaction ID: ${wallet.transaction!.transactionId}",

                  ),


                ],

              ),

            ),



          ],

        ),

      ),

    );

  }

}