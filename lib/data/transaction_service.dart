import 'dart:collection';

import 'package:ex_track/data/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

enum TransactionMode { income, expense }

int colorMode = 0;

class TransactionService extends ChangeNotifier {
  List<Transaction> _transactions = [];

  int _total = 0, _income = 0, _expense = 0;

  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView(_transactions);

  get total => (_total);
  get income => (_income);
  get expense => (_expense);

  final String transactionHiveBox = 'transaction-box';

  Future<void> createItem(Transaction transaction) async {
    if (transaction.transactionMode == TransactionMode.expense) {
      _total += transaction.amount;
      _expense += transaction.amount;
    } else {
      _total += transaction.amount;
      _income += transaction.amount;
    }
    Box<Transaction> box = await Hive.openBox<Transaction>(transactionHiveBox);
    await box.add(transaction);
    _transactions.add(transaction);
    _transactions = box.values.toList();
    notifyListeners();
  }

  Future<void> getItems() async {
    Box<Transaction> box = await Hive.openBox<Transaction>(transactionHiveBox);
    _transactions = box.values.toList();
    notifyListeners();
  }
}
