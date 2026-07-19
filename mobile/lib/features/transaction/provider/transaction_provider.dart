import 'package:flutter/material.dart';
import '../model/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {

  final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  void addTransaction(TransactionModel transaction) {
    _transactions.insert(0, transaction);
    notifyListeners();
  }

}