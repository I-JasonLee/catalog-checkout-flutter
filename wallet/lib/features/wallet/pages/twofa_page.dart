import 'package:flutter/material.dart';

import '../services/twofa_service.dart';


class TwoFAPage extends StatefulWidget {


final Function(bool success) callback;


const TwoFAPage({

super.key,

required this.callback,

});


@override
State<TwoFAPage> createState()=>_TwoFAPageState();


}



class _TwoFAPageState extends State<TwoFAPage>{


final controller =
TextEditingController();


String method="pin";


final service =
TwoFAService();



@override
Widget build(BuildContext context){


return Scaffold(

appBar: AppBar(
title:
const Text("2FA Verification"),
),


body: Padding(

padding:
const EdgeInsets.all(20),


child:Column(

children:[


DropdownButton<String>(

value: method,

items:[

"pin",
"otp",
"totp"

].map((e)=>

DropdownMenuItem(

value:e,

child:Text(e),

)

).toList(),


onChanged:(v){

setState((){

method=v!;

});

},


),


TextField(

controller:controller,

obscureText:true,

decoration:
const InputDecoration(
labelText:"Kode"
),

),


ElevatedButton(

onPressed:()async{


final result =
await service.verify(

method:method,

value:
controller.text,

);


widget.callback(result);


Navigator.pop(context);


},


child:
const Text("Verify"),

)



],


),


),


);


}


}