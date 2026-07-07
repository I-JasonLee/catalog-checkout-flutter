import 'package:flutter/material.dart';

import '../model/transaction_model.dart';


class WalletProvider extends ChangeNotifier {

  // saldo awal wallet
  int balance = 1000000;


  TransactionModel? transaction;


  // menerima request pembayaran dari merchant
  void setTransaction({
    required String transactionId,
    required int amount,
  }) {

    transaction = TransactionModel(
      transactionId: transactionId,
      amount: amount,
      status: "Menunggu Pembayaran",
    );


    notifyListeners();
  }



  // proses pembayaran setelah PIN benar
  bool pay() {

    if(transaction == null){
      return false;
    }


    if(balance < transaction!.amount){
      transaction = TransactionModel(
        transactionId: transaction!.transactionId,
        amount: transaction!.amount,
        status: "Saldo Tidak Cukup",
      );

      notifyListeners();

      return false;
    }


    // potong saldo
    balance -= transaction!.amount;


    transaction = TransactionModel(
      transactionId: transaction!.transactionId,
      amount: transaction!.amount,
      status: "Pembayaran Berhasil",
    );


    notifyListeners();


    return true;
  }

}