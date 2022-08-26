import 'package:ex_track/constants.dart';
import 'package:ex_track/data/transaction.dart';
import 'package:ex_track/pages/custom_widgets.dart';
import 'package:ex_track/pages/details.dart';
import 'package:flutter/material.dart';

class DetailList extends StatelessWidget {
  const DetailList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Transaction> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: () {
            customDialog(
                context: context, child: Details(index: index, tsList: list));
          },
          child: Container(
            decoration: BoxDecoration(
                color: kColorMap[list[index].transactionMode],
                borderRadius: kBorderRadius),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: ListTile(
              subtitle: Text(transactionList[index].desc),
              trailing: Text(transactionList[index].date),
              leading: Icon(
                kIconMap[list[index].transactionMode],
                size: 40,
              ),
              title: Text(
                list[index].amount.toString(),
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ),
        );
      }),
    );
  }
}
