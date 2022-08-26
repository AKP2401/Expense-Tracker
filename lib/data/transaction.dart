import 'package:flutter/foundation.dart';

enum TransactionMode { income, expense }

class Tracker with ChangeNotifier {
  int total = 0, income = 0, expense = 0;

  void earn(int amount) {
    total += amount;
    income += amount;
    notifyListeners();
  }

  void spend(int amount) {
    total -= amount;
    expense += amount;
    notifyListeners();
  }
}

class Transaction {
  final TransactionMode transactionMode;
  final int amount;
  final String desc, date, time;
  Transaction({
    required this.transactionMode,
    required this.amount,
    required this.desc,
    required this.date,
    required this.time,
  });
}

List<Transaction> transactionList = [];

int colorMode = 0;
