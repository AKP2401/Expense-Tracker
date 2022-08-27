import 'package:hive/hive.dart';
part 'transaction.g.dart';

enum TransactionMode { income, expense }

int colorMode = 0;

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  String amount;

  @HiveField(1)
  TransactionMode transactionMode;

  @HiveField(2)
  String date;

  @HiveField(3)
  String time;

  @HiveField(4)
  String desc;

  Transaction({
    required this.amount,
    required this.transactionMode,
    required this.desc,
    required this.date,
    required this.time,
  });
}
