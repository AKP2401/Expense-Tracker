import 'dart:collection';

import 'package:ex_track/data/transaction.dart';
import 'package:flutter/material.dart';

class TransactionService extends ChangeNotifier {
  List<Transaction> _transactions = [];

  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView(_transactions);
}
