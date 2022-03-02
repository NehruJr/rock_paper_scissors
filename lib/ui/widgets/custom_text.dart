import 'package:flutter/material.dart';

Widget customText(String result){
  Color color;
  switch(result){
    case 'Tie':
      color = Colors.black;
      break;
    case'You Win':
      color = Colors.green;
      break;
    case 'Computer Wins':
      color = Colors.red;
      break;
    default:
      color = Colors.black;
  }

  return Text(result , style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: color != null ? color : Colors.black
  ),);
}