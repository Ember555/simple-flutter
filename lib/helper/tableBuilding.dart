import 'package:flutter/material.dart';

TableRow buildTableRow(String listOfNames) {
  return TableRow(
    decoration: BoxDecoration(
      color: Colors.grey,
      gradient: LinearGradient(
          colors: [Colors.grey[200], Colors.grey[300]],
          begin: Alignment.centerRight,
          end: Alignment(1.0, 1.0)),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    children: listOfNames.split(',').map((name) {
      return Container(
        alignment: Alignment.centerLeft,
        child: Text(name, style: TextStyle(fontSize: 15.0)),
        padding: EdgeInsets.all(10.0),
      );
    }).toList(),
  );
}
