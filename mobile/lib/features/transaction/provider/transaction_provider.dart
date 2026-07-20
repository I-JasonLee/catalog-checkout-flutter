import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/transaction_model.dart';


class TransactionProvider extends ChangeNotifier {


  final List<TransactionModel> _transactions = [];


  List<TransactionModel> get transactions => _transactions;



  // ==========================
  // LOAD HISTORY TRANSACTION
  // ==========================

  Future<void> loadTransactions() async {


    final prefs =
        await SharedPreferences.getInstance();


    final data =
        prefs.getStringList("mobile_transactions");



    if(data != null){


      _transactions.clear();


      for(final item in data){


        final split =
            item.split("|");



        _transactions.add(

          TransactionModel(

            transactionId: split[0],

            amount:
              int.parse(split[1]),

            status:
              split[2],

          ),

        );


      }


    }


    notifyListeners();

  }





  // ==========================
  // ADD TRANSACTION
  // ==========================

  Future<void> addTransaction(
      TransactionModel transaction
  ) async {


    _transactions.insert(
      0,
      transaction,
    );


    await saveTransactions();


    notifyListeners();


  }





  // ==========================
  // SAVE TRANSACTION
  // ==========================

  Future<void> saveTransactions() async {


    final prefs =
        await SharedPreferences.getInstance();



    await prefs.setStringList(

      "mobile_transactions",


      _transactions.map((e)=>


        "${e.transactionId}|${e.amount}|${e.status}"


      ).toList(),


    );


  }



}