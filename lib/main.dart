import 'package:flutter_web/material.dart';
import './components/secondPage.dart';
import './components/firstPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'OpenSans',
    ),
    title: 'Admin Console',
    initialRoute: '/',
    routes: {
      '/': (context) => FirstPage(),
      '/second': (context) => SecondScreen(),
    },
  ));
}
