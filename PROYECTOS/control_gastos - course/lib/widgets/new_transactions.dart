import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import '../widgets/adaptive_flat_button.dart';
import '../widgets/categories_dropdown_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTX;
  NewTransaction(this.addNewTX);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _category;
  DateTime _selectedDate;

  void submit() {
    final String enteredTitle = _titleController.text;
    final double enteredAmount = double.parse(_amountController.text);

    //basic validation
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    this.widget.addNewTX(enteredTitle, enteredAmount, _selectedDate, _category);
    Navigator.of(context).pop();

    ///para cerrar el modal cuando se hace el submit
  }

  void _getCategorieDropDown(cat) {
    this._category = cat;
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(
        new Duration(days: 60),
      ),
    ).then((dateSelected) {
      if (dateSelected == null) return;

      setState(() {
        this._selectedDate = dateSelected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                15 //para sumarle al padding el tamaño del teclado y
            //empuje el card hacia arriba
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 20, //it´s like a <br/> or <hr/>
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              controller: _titleController,
              // onChanged: (val) {
              //   this.titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Monto'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _amountController,
              onSubmitted: (_) => submit(),
              // onChanged: (val) => this.amountInput = val,
            ),
            SizedBox(
              height: 20, //it´s like a <br/> or <hr/>
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text('Categoría'),
                  ),
                  CategoriesDropDown(_getCategorieDropDown),
                ],
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Sin Fecha'
                          : 'Fecha elegida:  ${DateFormat.yMMMd().format(this._selectedDate)}',
                    ),
                  ),
                  AdaptiveFlatButton(
                    'Seleccione una fecha',
                    this._presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Agregar Item'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).buttonColor,
              onPressed: () {
                submit();
              },
            ),
          ],
        ),
      ),
    );
  }
}
