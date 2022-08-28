// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ex_track/constants.dart';
import 'package:ex_track/data/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ex_track/data/transaction.dart';
import 'package:provider/provider.dart';

class PopUp extends StatelessWidget {
  Color bgColor;
  TransactionMode transactionMode;
  PopUp({required this.bgColor, required this.transactionMode});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController1 = TextEditingController(),
        textEditingController2 = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      child: StatefulBuilder(builder: (context, setState) {
        final tracker = Provider.of<TransactionService>(context);
        return Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: kBorderRadius,
          ),
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(8.0),
              child: TextField(
                autofocus: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Amount",
                  border: InputBorder.none,
                ),
                controller: textEditingController1,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Description",
                  border: InputBorder.none,
                ),
                controller: textEditingController2,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: kBorderRadius,
                          color: Color.fromRGBO(172, 188, 196, 1)),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                TextButton(
                  onPressed: () {
                    int amount = int.parse(textEditingController1.text);
                    String desc = textEditingController2.text;
                    var dt = DateTime.now();
                    String date = "${dt.day}/${dt.month}/${dt.year}";
                    String min = "";
                    if (dt.minute == 0) min = "00";
                    String time = "${dt.hour}:$min:${dt.second}";
                    Transaction transaction = Transaction(
                        transactionMode: transactionMode,
                        amount: amount,
                        desc: desc,
                        date: date,
                        time: time);
                    tracker.createItem(transaction);
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: kBorderRadius,
                          color: Color.fromRGBO(172, 188, 196, 1)),
                      child: Text("CONFIRM",
                          style: TextStyle(color: Colors.black))),
                ),
              ],
            )
          ]),
        );
      }),
    );
  }
}
