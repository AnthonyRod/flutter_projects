import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);
  final formatCurrency = new NumberFormat.compact();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, contrains) {
        return Column(
          children: <Widget>[
            Container(
              height: contrains.maxHeight * 0.15,
              child: FittedBox(
                //para que se ajuste al tamalo disponible del elemento padre (shrink)
                child: Text('₡${formatCurrency.format(spendingAmount)}'),
              ),
            ),
            SizedBox(
              height: contrains.maxHeight * 0.05,
            ),
            Container(
              height: contrains.maxHeight * 0.6,
              width: 11,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: contrains.maxHeight * 0.05,
            ),
            FittedBox(
              //para que se ajuste al tamalo disponible del elemento padre (shrink)
              child: Container(
                height: contrains.maxHeight * 0.15,
                child: FittedBox(
                  child: Text(label),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
