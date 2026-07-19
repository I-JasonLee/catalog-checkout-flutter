import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/wallet_provider.dart';


class TransactionHistoryPage extends StatelessWidget {

  const TransactionHistoryPage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {


    final wallet =
        Provider.of<WalletProvider>(context);



    return Scaffold(

      appBar: AppBar(
        title:
        const Text(
          "Transaction History",
        ),
      ),


      body:

      wallet.history.isEmpty

      ?

      const Center(
        child:
        Text(
          "Belum ada transaksi",
        ),
      )


      :

      ListView.builder(

        itemCount:
        wallet.history.length,


        itemBuilder:
        (context,index){


          final item =
          wallet.history[index];


          return Card(

            margin:
            const EdgeInsets.all(10),


            child:
            ListTile(

              title:
              Text(
                item.status,
              ),


              subtitle:
              Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children:[

                  Text(
                    "ID: ${item.transactionId}",
                  ),

                  Text(
                    "Amount: Rp ${item.amount}",
                  ),

                  Text(
                    item.date,
                  ),

                ],

              ),

            ),

          );


        },

      ),


    );

  }

}