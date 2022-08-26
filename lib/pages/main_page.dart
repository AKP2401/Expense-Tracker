import 'package:ex_track/constants.dart';
import 'package:ex_track/data/transaction.dart';
import 'package:ex_track/pages/details.dart';
import 'package:ex_track/pages/input.dart';
import 'package:ex_track/pages/sorted.dart';
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
    final tracker = Provider.of<Tracker>(context);
    double grad = tracker.income.toDouble() / tracker.total.toDouble();
    Map<String, dynamic> colorTheme = kColorMode[colorMode % 2];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedContainer(
        duration: Duration(milliseconds: 350),
        color: colorTheme['bgColor'],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              tracker.total.toInt().toString(),
              style: TextStyle(fontSize: 60, color: colorTheme['fontColor']),
            ),
            customBar(context),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  newLabel(
                      value: tracker.income.toInt().toString(),
                      right: 5,
                      transactionMode: TransactionMode.income),
                  newLabel(
                      value: tracker.expense.toInt().toString(),
                      left: 5,
                      transactionMode: TransactionMode.expense)
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 350),
              foregroundDecoration: BoxDecoration(borderRadius: kBorderRadius),
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 400,
              decoration: BoxDecoration(
                borderRadius: kBorderRadius,
                color: colorTheme['bgColor'],
              ),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: transactionList.length,
                  itemBuilder: (context, index) {
                    Color? bgColor =
                        kColorMap[transactionList[index].transactionMode];
                    IconData? preIcon =
                        kIconMap[transactionList[index].transactionMode];

                    return GestureDetector(
                      onTap: () {
                        Vibration.vibrate();
                        showDialog(
                          context: context,
                          builder: ((context) {
                            return Details(
                              index: index,
                              tsList: transactionList,
                            );
                          }),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: kBorderRadius,
                        ),
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        child: ListTile(
                          subtitle: Text(transactionList[index].desc),
                          trailing: Text(transactionList[index].date),
                          leading: Icon(
                            preIcon,
                            size: 40,
                          ),
                          title: Text(
                            "${transactionList[index].amount}",
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    );
                  }),
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
                  duration: Duration(milliseconds: 350),
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
                          turns: child.key == ValueKey('icon1')
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
                                key: ValueKey('icon1'),
                              )
                            : Icon(
                                kColorMode[1]['icon'],
                                key: ValueKey('icon2'),
                              ),
                      )),
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

  Expanded newLabel(
      {required String value,
      required TransactionMode transactionMode,
      double left = 0,
      double right = 0}) {
    final bgColor = kColorMap[transactionMode];
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return Sorted(transactionMode: transactionMode);
              });
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
              showDialog(
                  context: context,
                  builder: ((context) {
                    return PopUp(
                        bgColor: bgColors, transactionMode: transactionMode);
                  }));
            },
          );
        },
        icon: icon,
      ),
    );
  }

  Container customBar(BuildContext context) {
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
        boxShadow: const [
          BoxShadow(
              color: Colors.black, offset: Offset(2.0, 2.0), blurRadius: 4)
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: g.toInt(),
            child: Container(
              color: Color.fromARGB(255, 113, 182, 148),
            ),
          ),
          Expanded(
            flex: f.toInt(),
            child: Container(
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
