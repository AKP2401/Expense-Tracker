import 'package:ex_track/constants.dart';
import 'package:ex_track/data/transaction.dart';
import 'package:ex_track/data/transaction_service.dart';
import 'package:ex_track/pages/custom_widgets.dart';
import 'package:ex_track/pages/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class DetailList extends StatelessWidget {
  const DetailList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<int> list;

  @override
  Widget build(BuildContext context) {
    final tracker = Provider.of<TransactionService>(context);
    // tracker.getItems();
    final transactionList = tracker.transactions;

    return StatefulBuilder(builder: (context, setState) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: ((context, index) {
          return Container(
            decoration: BoxDecoration(
                color: kColorMap[transactionList[list[index]].transactionMode],
                borderRadius: kBorderRadius),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            // height: 120,
            child: ListTile(
              onTap: () {
                Vibration.vibrate(
                    duration: 180, intensities: [1, 2, 3], pattern: [3, 2, 1]);
                customDialog(
                    context: context,
                    child: Details(index: index, tsList: transactionList));
              },
              subtitle: Text(transactionList[list[index]].desc),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 1, child: Text(transactionList[list[index]].date)),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      color: Colors.redAccent,
                      onPressed: () {
                        setState(() {
                          tracker.deleteItem(index);
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 35,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              leading: Icon(
                kIconMap[transactionList[list[index]].transactionMode],
                size: 40,
              ),
              title: Text(
                transactionList[list[index]].amount.toString(),
                style: const TextStyle(fontSize: 30),
              ),
            ),
          );
        }),
      );
    });
  }
}
