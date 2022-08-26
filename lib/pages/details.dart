import 'package:ex_track/constants.dart';
import 'package:ex_track/data/transaction.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final int index;
  final List<Transaction> tsList;
  Details({required this.index, required this.tsList});

  @override
  Widget build(BuildContext context) {
    final Transaction ti = tsList[index];
    final Color? bgColor = kColorMap[ti.transactionMode];

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(color: bgColor, borderRadius: kBorderRadius),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              ti.amount.toString(),
              style: TextStyle(fontSize: 50),
            ),
            Text(
              ti.desc,
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DT("DATE", ti.date),
                DT("TIME", ti.time),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column DT(String data, String content) {
    return Column(
      children: [
        Text(
          data,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(content),
      ],
    );
  }
}
