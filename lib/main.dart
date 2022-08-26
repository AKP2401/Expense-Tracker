import 'package:ex_track/data/transaction.dart';
import 'package:ex_track/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Tracker>(
      create: (_) => Tracker(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (context) => const MainPage(),
        },
      ),
    );
  }
}
