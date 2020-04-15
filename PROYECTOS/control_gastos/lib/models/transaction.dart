import 'package:flutter/foundation.dart';

///para poder ussar el @required

class Transaction {
  String id;
  String title;
  double amount;
  String categoria;
  DateTime date;

  Transaction(
      {@required this.amount,
      @required this.date,
      @required this.id,
      @required this.title,
      @required this.categoria});
}
