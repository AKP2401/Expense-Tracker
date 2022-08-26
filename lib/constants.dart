import 'package:ex_track/data/transaction.dart';
import 'package:flutter/material.dart';

const Map<TransactionMode, Color> kColorMap = {
  TransactionMode.income: Color.fromRGBO(130, 161, 143, 1),
  TransactionMode.expense: Color.fromRGBO(236, 142, 117, 1),
};

const BorderRadius kBorderRadius = BorderRadius.all(Radius.circular(10));

const Map<TransactionMode, IconData> kIconMap = {
  TransactionMode.income: Icons.add,
  TransactionMode.expense: Icons.remove,
};

const List<Map<String, dynamic>> kColorMode = [
  {
    'bgColor': Color.fromRGBO(245, 215, 200, 0.6),
    'fontColor': Colors.black,
    'icon': Icons.sunny_snowing,
    'iconBgColor': Color.fromARGB(244, 20, 19, 18),
  },
  {
    'bgColor': Color.fromARGB(244, 20, 19, 18),
    'fontColor': Colors.white,
    'icon': Icons.sunny,
    'iconBgColor': Color.fromRGBO(245, 215, 200, 0.6),
  }
];
