import 'package:flutter/material.dart';
import '../model/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletProvider extends ChangeNotifier {

  // saldo awal wallet
  int balance = 1000000;


  TransactionModel? transaction;

  String? jwtToken;

   void setToken(String token) {

    jwtToken = token;

    notifyListeners();

  }

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

    saveBalance();

    transaction = TransactionModel(
      transactionId: transaction!.transactionId,
      amount: transaction!.amount,
      status: "Pembayaran Berhasil",
    );


    notifyListeners();


    return true;
  }

  Future<void> loadBalance() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("wallet_balance")) {
      balance = prefs.getInt("wallet_balance")!;
    } else {
      balance = 1000000;
      await prefs.setInt(
        "wallet_balance",
        balance,
      );
    }

    notifyListeners();
  }

  Future<void> saveBalance() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      "wallet_balance",
      balance,
    );
  }

    Future<void> resetBalance() async {
    balance = 1000000;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      "wallet_balance",
      balance,
    );

    notifyListeners();
  }

}