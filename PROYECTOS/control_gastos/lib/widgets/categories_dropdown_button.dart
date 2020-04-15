import 'package:flutter/material.dart';

class CategoriesDropDown extends StatefulWidget {
  final Function sentCategorieValue;
  CategoriesDropDown(this.sentCategorieValue);
  @override
  _CategoriesDropDownState createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown> {
  List<String> categorias = <String>[
    'Gastos',
    'Deuda',
    'Ahorro',
    'Ocio',
    'Gastos Personales'
  ];
  String dropdownValue = 'Gastos'; //valor inicializado

  @override
  Widget build(BuildContext context) {
    this.widget.sentCategorieValue(
        this.dropdownValue); //para enviar el valor inicializado

    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 10,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          this.widget.sentCategorieValue(this.dropdownValue); //envia el calor a new_transaction
        });
      },
      items: categorias.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
