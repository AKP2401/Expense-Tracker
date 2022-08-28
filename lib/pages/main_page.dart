import 'package:ex_track/constants.dart';
import 'package:ex_track/data/transaction.dart';
import 'package:ex_track/data/transaction_service.dart';
import 'package:ex_track/pages/custom_widgets.dart';
import 'package:ex_track/pages/detail_list.dart';
import 'package:ex_track/pages/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final tracker = Provider.of<TransactionService>(context);
    tracker.getItems();
    final transactionList = tracker.transactions;
    Map<String, dynamic> colorTheme = kColorMode[colorMode % 2];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        color: colorTheme['bgColor'],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 20,
            ),
            Hero(
              tag: 'balance',
              child: Text(
                tracker.total.toInt().toString(),
                style: TextStyle(
                    fontSize: 60,
                    color: colorTheme['fontColor'],
                    fontWeight: FontWeight.bold),
              ),
            ),
            CustomBar(
              income: tracker.income,
              expense: tracker.expense,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NewLabel(
                    value: tracker.income.toInt().toString(),
                    right: 5,
                    transactionMode: TransactionMode.income,
                    context: context,
                  ),
                  NewLabel(
                    value: tracker.expense.toInt().toString(),
                    left: 5,
                    transactionMode: TransactionMode.expense,
                    context: context,
                  )
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              foregroundDecoration:
                  const BoxDecoration(borderRadius: kBorderRadius),
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 400,
              decoration: BoxDecoration(
                borderRadius: kBorderRadius,
                color: colorTheme['bgColor'],
              ),
              child: DetailList(
                list: List<int>.generate(
                    transactionList.length, (index) => index),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button(
                  context,
                  kColorMap[TransactionMode.income]!,
                  TransactionMode.income,
                  const Icon(Icons.add),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorTheme['iconBgColor'],
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4)
                    ],
                  ),
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        Vibration.vibrate();
                        final sM = ScaffoldMessenger.of(context);

                        sM.showSnackBar(
                          SnackBar(
                            content: const Text('Cleared All'),
                            action: SnackBarAction(
                                label: "DONE",
                                onPressed: sM.hideCurrentSnackBar),
                          ),
                        );
                        tracker.clearItems();
                      });
                    },
                    child: IconButton(
                      color: colorTheme['bgColor'],
                      onPressed: () {
                        setState(() {
                          colorMode += 1;
                        });
                      },
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        transitionBuilder: (child, animation) =>
                            RotationTransition(
                          turns: child.key == const ValueKey('icon1')
                              ? Tween<double>(begin: 1, end: 0.75)
                                  .animate(animation)
                              : Tween<double>(begin: 0.75, end: 1)
                                  .animate(animation),
                          child:
                              ScaleTransition(scale: animation, child: child),
                        ),
                        child: colorMode % 2 == 0
                            ? Icon(
                                kColorMode[0]['icon'],
                                key: const ValueKey('icon1'),
                              )
                            : Icon(
                                kColorMode[1]['icon'],
                                key: const ValueKey('icon2'),
                              ),
                      ),
                    ),
                  ),
                ),
                button(
                  context,
                  kColorMap[TransactionMode.expense]!,
                  TransactionMode.expense,
                  const Icon(Icons.remove),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container button(BuildContext context, Color bgColors,
      TransactionMode transactionMode, Icon icon) {
    return Container(
      decoration: BoxDecoration(
        color: bgColors,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
              color: Colors.black, offset: Offset(2.0, 2.0), blurRadius: 4)
        ],
      ),
      child: IconButton(
        onPressed: () {
          setState(
            () {
              customDialog(
                  context: context,
                  child: PopUp(
                      bgColor: bgColors, transactionMode: transactionMode));
            },
          );
        },
        icon: icon,
      ),
    );
  }
}
