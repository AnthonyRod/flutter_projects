import 'dart:io';

///para verificar que plataforma es

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

///stilos para ios (scafold)
import "package:flutter/services.dart";

import "./widgets/transaction_list.dart";
import "./widgets/new_transactions.dart";
import "./models/transaction.dart";
import "./widgets/chart.dart";

void main() {
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        //fontFamily: 'ASMAN',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              //   fontFamily: 'ASMAN',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(color: Colors.white)),
        //appBarTheme: AppBarTheme(color: Colors.amber)
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    // fontFamily: 'ASMAN',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      title: 'Control de Gastos',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shows',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 39.99,
    //   date: DateTime.now(),
    // )
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String title, double amount, DateTime selectedDate, String categoria) {
    final newTx = Transaction(
      amount: amount,
      date: selectedDate == null ? DateTime.now() : selectedDate,
      id: DateTime.now().toString(), //for now
      title: title,
      categoria: categoria,
    );
    setState(() {
      _userTransactions.add(newTx);

      ///final variables can be modified
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},

          ///para que no se cierre si se preciona sobre el modal ella
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
      isScrollControlled:
          true, // => para que el modal oocupe toda la pantalla o se pueda empujar al abrir el teclado!!!
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQryInfo = MediaQuery.of(context);
    final isLandscape = mediaQryInfo.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Mi Presupuesto y Gastos'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min, //
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ))
        : AppBar(
            title: Text('Mi Presupuesto y Gastos'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );

    final txListWidget = Container(
        height: (mediaQryInfo.size.height -
                appBar.preferredSize.height -
                mediaQryInfo.padding.top) *
            0.75,
        child: TransactionList(_userTransactions, _deleteTransaction));

    final bodyWidget = SafeArea(
      // para asegurarse que se respetan las areas de los notch y otras que ios tiene y lo selementos se posicionan de forma correcta sin invadir esas áreas recervadas coomo el notch
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Mostrar Gráfico',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Switch.adaptive(
                    //adaptive para que se adapte a los controles de IOS
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                height: (mediaQryInfo.size.height -
                        appBar.preferredSize.height -
                        mediaQryInfo.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQryInfo.size.height -
                              appBar.preferredSize.height -
                              mediaQryInfo.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyWidget,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyWidget,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS

                ///verifica que sistema operativo es!!!!
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
