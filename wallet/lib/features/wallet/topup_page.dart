import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/wallet_provider.dart';


class TopUpPage extends StatelessWidget {

  const TopUpPage({super.key});


  @override
  Widget build(BuildContext context) {


    final controller =
        TextEditingController();


    return Scaffold(

      appBar: AppBar(
        title:
        const Text(
          "Top Up Wallet",
        ),
      ),


      body:
      Padding(

        padding:
        const EdgeInsets.all(20),


        child:
        Column(

          children: [


            TextField(

              controller:
              controller,

              keyboardType:
              TextInputType.number,

              decoration:
              const InputDecoration(

                labelText:
                "Nominal Top Up",

              ),

            ),


            const SizedBox(height:20),


            ElevatedButton(

              onPressed: () async {


                final amount =
                    int.parse(
                      controller.text,
                    );


                await Provider.of<WalletProvider>(
                  context,
                  listen:false,
                ).topUp(amount);



                Navigator.pop(context);


              },

              child:
              const Text(
                "Tambah Saldo",
              ),

            )


          ],

        ),

      ),

    );

  }

}