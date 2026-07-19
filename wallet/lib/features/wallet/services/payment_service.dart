import 'dart:convert';
import 'package:http/http.dart' as http;


class PaymentService {


  Future<bool> payment({

    required String transactionId,
    required int amount,
    required String token,

  }) async {


    final response = await http.post(

      Uri.parse(
        "http://10.0.2.2:3000/payment",
      ),


      headers: {

        "Content-Type":
            "application/json",


        "Authorization":
            "Bearer $token",

      },


      body: jsonEncode({

        "transactionId":
            transactionId,


        "amount":
            amount,

      }),

    );


    print(
      "PAYMENT STATUS:"
    );

    print(
      response.statusCode
    );


    print(
      "PAYMENT RESPONSE:"
    );

    print(
      response.body
    );


    return response.statusCode == 200;

  }

}