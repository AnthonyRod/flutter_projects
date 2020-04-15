import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart'; //para formatear fechas y números  //https://pub.dev/packages/intl#-installing-tab-
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;
  TransactionList(this._userTransactions, this._deleteTransaction);

  final formatCurrency = new NumberFormat.compact();

  ///para formaterar el numero

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQryInfo = MediaQuery.of(context);
    return _userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, contrains) {
              return Column(
                children: <Widget>[
                  Text(
                    'Nothing added yet',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20, //it´s like a <br/> or <hr/>
                  ),
                  Container(
                    height: contrains.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/pngocean-empty.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 1, horizontal: 7),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                          '${formatCurrency.format(_userTransactions[index].amount)}',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    _userTransactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _userTransactions[index].categoria,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd()
                            .format(_userTransactions[index].date),
                      ),
                    ],
                  ),
                  trailing: mediaQryInfo.size.width >
                          450 //para mostrar mas labes dependiendo del ancho del dispositivo
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Borrar'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () =>
                              _deleteTransaction(_userTransactions[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              _deleteTransaction(_userTransactions[index].id),
                        ),
                ),
              );
              //     Card(
              //   elevation: 3,
              //   margin: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              //   child: Row(
              //     children: <Widget>[
              //       Expanded(
              //         flex: 3,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: <Widget>[
              //             Container(
              //               padding: EdgeInsets.all(6),
              //               margin: EdgeInsets.symmetric(
              //                 vertical: 5,
              //                 horizontal: 10,
              //               ),
              //               decoration: BoxDecoration(
              //                   // border: Border.all(
              //                   //   color: Theme.of(context).primaryColor,
              //                   //   width: 1,
              //                   // ),
              //                   ),
              //               child: FittedBox(
              //                 ///para que el texto se ajusta deacuerdo al tamañp disponible
              //                 child: Text(
              //                   '₡ ${formatCurrency.format(_userTransactions[index].amount)}',

              //                   ///para formaterar el numero
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.bold,
              //                       fontSize: 15,
              //                       color: Theme.of(context)
              //                           .primaryColorDark //Colors.deepPurple,
              //                       ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Expanded(
              //         flex: 7,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Text(_userTransactions[index].title,
              //                 style: Theme.of(context).textTheme.title
              //                 // style: TextStyle(
              //                 //   fontWeight: FontWeight.bold,
              //                 //   fontSize: 16,
              //                 // ),
              //                 ),
              //             Text(
              //               //DateFormat('yyyy-MM-dd').format(tx.date),
              //               DateFormat.yMMMd()
              //                   .format(_userTransactions[index].date),
              //               style: TextStyle(
              //                   color: Colors.blueGrey, fontSize: 12),
              //             ),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // );
            },
            itemCount: _userTransactions.length,
            /////IMPORTANTE!!!!!! sin esto no funciona el LIstView builder => para que renderice solo lo que se ve en pantalla para mejor rendimindo te memoria
          );
  }
}
