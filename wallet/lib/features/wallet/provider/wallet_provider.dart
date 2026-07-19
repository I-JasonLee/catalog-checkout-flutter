import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/transaction_model.dart';

class WalletProvider extends ChangeNotifier {
  int balance = 1000000;
  TransactionModel? transaction;
  String? jwtToken;
  void setToken(String token){
    jwtToken = token;
    notifyListeners();
  }

  // HISTORY TRANSAKSI
  List<TransactionModel> history = [];

  // =========================
  // TERIMA REQUEST PEMBAYARAN
  // =========================

  void setTransaction({
    required String transactionId,
    required int amount,
  })
  {
    transaction = TransactionModel(
      transactionId: transactionId,
      amount: amount,
      status: "Menunggu Pembayaran",
      date: DateTime.now().toString(),
    );
    notifyListeners();
  }

  // =========================
  // LOAD HISTORY
  // =========================

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList("transaction_history");
    if(data != null){
      history = data.map((item){
          final split = item.split("|");
          return TransactionModel(
            transactionId: split[0],
            amount: int.parse(split[1]),
            status: split[2],
            date: split[3],
          );
        }).toList();
    }
    notifyListeners();
  }

  // =========================
  // SIMPAN HISTORY
  // =========================

  Future<void> saveHistory(
      TransactionModel transaction
  ) async {
    history.insert(0, transaction,);
    final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        "transaction_history", history.map(
          (e)=> "${e.transactionId}|${e.amount}|${e.status}|${e.date}"
        ).toList(),
      );
    notifyListeners();
  }

  // =========================
  // BAYAR
  // =========================

  Future<bool> pay() async {
    if(transaction == null){return false;}
    if(balance < transaction!.amount){
      transaction = TransactionModel(
        transactionId: transaction!.transactionId,
        amount: transaction!.amount,
        status: "Saldo Tidak Cukup",
        date: DateTime.now().toString(),
      );
      notifyListeners();
      return false;
    }
    // Kurangi Saldo
    balance -= transaction!.amount;
    // Simpan Saldo
      final prefs = await SharedPreferences.getInstance();
        await prefs.setInt("balance", balance,);
    // Update Transaksi Berhasil
    transaction =
    TransactionModel(
      transactionId: transaction!.transactionId,
      amount: transaction!.amount,
      status: "Pembayaran Berhasil",
      date: DateTime.now().toString(),
    );
    // Simpan History
    await saveHistory(transaction!);
    notifyListeners();
    return true;
  }

  Future<void> loadBalance() async {
    final prefs = await SharedPreferences.getInstance();
    balance = prefs.getInt("balance") ?? 1000000;
    notifyListeners();
  }

  Future<void> topUp(int amount) async {
    balance += amount;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      "balance",balance,
    );
    notifyListeners();
  }
  
}