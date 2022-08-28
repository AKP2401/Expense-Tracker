// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 0;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction(
      amount: fields[0] as int,
      transactionMode: fields[1] as TransactionMode,
      desc: fields[4] as String,
      date: fields[2] as String,
      time: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.transactionMode)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.desc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrackerAdapter extends TypeAdapter<Tracker> {
  @override
  final int typeId = 2;

  @override
  Tracker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tracker(
      expense: fields[1] as int,
      income: fields[2] as int,
      total: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Tracker obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.total)
      ..writeByte(1)
      ..write(obj.expense)
      ..writeByte(2)
      ..write(obj.income);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionModeAdapter extends TypeAdapter<TransactionMode> {
  @override
  final int typeId = 1;

  @override
  TransactionMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionMode.income;
      case 1:
        return TransactionMode.expense;
      default:
        return TransactionMode.income;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionMode obj) {
    switch (obj) {
      case TransactionMode.income:
        writer.writeByte(0);
        break;
      case TransactionMode.expense:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
