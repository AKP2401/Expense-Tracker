import 'package:ex_track/constants.dart';
import 'package:ex_track/data/transaction.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final int index;
  final List<Transaction> tsList;
  const Details({Key? key, required this.index, required this.tsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Transaction ti = tsList[index];
    final Color? bgColor = kColorMap[ti.transactionMode];

    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 200,
        width: 200,
        decoration: BoxDecoration(color: bgColor, borderRadius: kBorderRadius),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              ti.amount.toString(),
              style: const TextStyle(fontSize: 50),
            ),
            Text(
              ti.desc,
              style: const TextStyle(fontSize: 20),
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(content),
      ],
    );
  }
}
