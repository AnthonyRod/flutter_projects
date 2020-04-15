import './chart_bar.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    final formater = new DateFormat('yyyy-MM-dd');
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = recentTransactions
            .where((t) => formater.format(t.date) == formater.format(weekDay))
            .fold(0, (a, b) => a + b.amount);
        //for (var i = 0; i < recentTransactions.length; i++) {}
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum,
        };
      },
    ).reversed.toList(); //para order nar los dias 
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (a, b) => a + b['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10), // para dar espacion al rededor del ROW
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          ///distribuye los elementos en el espacio disponible de forma uniforme
          children: groupedTransactionValues.map((data) {
            return Flexible(
              //flex: 1,
              fit: FlexFit.tight, // para que se ajuste igual a todos
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
