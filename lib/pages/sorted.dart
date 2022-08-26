import 'package:ex_track/constants.dart';
import 'package:ex_track/data/transaction.dart';
import 'package:ex_track/pages/detail_list.dart';
import 'package:ex_track/pages/details.dart';
import 'package:flutter/material.dart';

class Sorted extends StatelessWidget {
  const Sorted({Key? key, required this.transactionMode}) : super(key: key);
  final TransactionMode transactionMode;

  @override
  Widget build(BuildContext context) {
    List<Transaction> filter(TransactionMode transactionMode) {
      List<Transaction> output = [];
      for (int i = 0; i < transactionList.length; ++i) {
        if (transactionList[i].transactionMode == transactionMode) {
          output.add(transactionList[i]);
        }
      }
      return output;
    }

    final list = filter(transactionMode);
    final bgColor = kColorMap[transactionMode];
    final preIcon = kIconMap[transactionMode];
    Map<String, dynamic> colorTheme = kColorMode[colorMode % 2];

    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: kBorderRadius, color: colorTheme['bgColor']),
        child: DetailList(list: list),
      ),
    );
  }
}
