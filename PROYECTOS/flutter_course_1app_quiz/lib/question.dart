//st to shoe autocomplete and insert snipppet
import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  ///final means it cant be reasigned once passed

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container (
            width : double.infinity,
            margin : EdgeInsets.all(15), //margen en todas las direcciones
            child : Text( 
              questionText, 
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
                
        
                ) 
    );
  }
}
