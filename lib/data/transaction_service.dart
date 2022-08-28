import 'dart:collection';

import 'package:ex_track/data/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

int colorMode = 0;

class TransactionService extends ChangeNotifier {
  List<Transaction> _transactions = [];

  int _total = 0, _income = 0, _expense = 0;

  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView(_transactions);

  get total => _total;
  get income => _income;
  get expense => _expense;

  final String transactionHiveBox = 'transaction-box';
  final String trackerHiveBox = 'tracker-box';

  createItem(Transaction transaction) async {
    Box<Transaction> box1 = await Hive.openBox<Transaction>(transactionHiveBox);
    Box<Tracker> box2 = await Hive.openBox<Tracker>(trackerHiveBox);
    _getTracker();
    await box1.add(transaction);
    await box2.delete('tracker');
    if (transaction.transactionMode == TransactionMode.expense) {
      _total -= transaction.amount;
      _expense += transaction.amount;
    } else {
      _total += transaction.amount;
      _income += transaction.amount;
    }
    await box2.put(
      'tracker',
      Tracker(
        expense: _expense,
        income: _income,
        total: _total,
      ),
    );
    _transactions.add(transaction);
    _transactions = box1.values.toList();
    notifyListeners();
  }

  _getTracker() async {
    Box<Tracker> box2 = await Hive.openBox<Tracker>(trackerHiveBox);
    if (box2.containsKey('tracker')) {
      Tracker tracker = box2.get('tracker')!;
      _income = tracker.income;
      _total = tracker.total;
      _expense = tracker.expense;
    } else {
      box2.put(
        'tracker',
        Tracker(
          income: 0,
          expense: 0,
          total: 0,
        ),
      );
    }
  }

  getItems() async {
    Box<Transaction> box1 = await Hive.openBox<Transaction>(transactionHiveBox);
    _getTracker();
    _transactions = box1.values.toList();

    notifyListeners();
  }
}
