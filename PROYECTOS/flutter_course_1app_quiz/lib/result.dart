import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function reserHandler;

  Result(this.resultScore, this.reserHandler);
  String get resultPhrase {
    var resultText = 'You did it!';
    if (this.resultScore <= 8) {
      resultText = 'Your are awesome and innocent!!!';
    } else if (resultScore <= 12) {
      resultText = 'Nada mal!';
    } else {
      resultText = 'you Suck!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text('Restart Quiz'),
            onPressed: () => reserHandler(),
          )
        ],
      ),
    );
  }
}
