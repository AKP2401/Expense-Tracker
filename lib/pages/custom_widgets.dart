import 'package:ex_track/constants.dart';
import 'package:ex_track/data/transaction.dart';
import 'package:ex_track/pages/sorted.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<Object?> customDialog(
    {required Widget child, required BuildContext context}) {
  return showGeneralDialog(
      transitionDuration: Duration(milliseconds: 150),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
            scale: a1.value, child: Opacity(opacity: a1.value, child: child));
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      });
}

class CustomBar extends StatelessWidget {
  const CustomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tracker = Provider.of<Tracker>(context);
    int g = tracker.income, f = tracker.expense;
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(221, 216, 213, 1),
        borderRadius: kBorderRadius,
        boxShadow: [
          BoxShadow(
              color: Colors.black, offset: Offset(2.0, 2.0), blurRadius: 4)
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: g.toInt(),
            child: Container(
              color: kColorMap[TransactionMode.income],
            ),
          ),
          Expanded(
            flex: f.toInt(),
            child: Container(
              color: kColorMap[TransactionMode.expense],
            ),
          ),
        ],
      ),
    );
  }
}

class NewLabel extends StatelessWidget {
  NewLabel(
      {Key? key,
      required this.context,
      required this.transactionMode,
      required this.value,
      this.left = 0,
      this.right = 0})
      : super(key: key);

  final BuildContext context;
  final TransactionMode transactionMode;
  final String value;
  double right, left;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = kColorMap[transactionMode]!;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          if (value != "0") {
            customDialog(
                child: Sorted(transactionMode: transactionMode),
                context: context);
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10, right: right, left: left),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
                color: Colors.black, offset: Offset(2.0, 2.0), blurRadius: 4)
          ], color: bgColor, borderRadius: kBorderRadius),
          height: 50,
          child: Center(
            child: Text(
              value,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
