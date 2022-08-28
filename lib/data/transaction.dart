import 'package:ex_track/data/transaction_service.dart';
import 'package:hive/hive.dart';
part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  int amount;

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
