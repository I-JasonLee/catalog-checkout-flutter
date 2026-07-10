import 'package:flutter/material.dart';

import 'services/pin_service.dart';


class SetPinPage extends StatefulWidget {

  const SetPinPage({super.key});


  @override
  State<SetPinPage> createState()
      => _SetPinPageState();

}



class _SetPinPageState
    extends State<SetPinPage> {


  final controller =
      TextEditingController();


  final PinService pinService =
      PinService();



  void save() async {


    await pinService.savePin(
      controller.text,
    );


    ScaffoldMessenger.of(context)
        .showSnackBar(
          const SnackBar(
            content:
            Text(
              "PIN berhasil dibuat",
            ),
          ),
        );


    Navigator.pop(context);


  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title:
        const Text(
          "Buat PIN Wallet",
        ),
      ),


      body: Padding(

        padding:
        const EdgeInsets.all(20),


        child: Column(

          children: [


            TextField(

              controller:
              controller,


              keyboardType:
              TextInputType.number,


              obscureText:
              true,


              decoration:
              const InputDecoration(
                labelText:
                "PIN 6 digit",
              ),

            ),


            const SizedBox(height:20),


            ElevatedButton(

              onPressed:
              save,


              child:
              const Text(
                "Simpan PIN",
              ),

            )

          ],

        ),

      ),

    );

  }

}