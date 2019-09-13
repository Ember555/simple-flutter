import 'package:flutter/material.dart';
import './components/thirdPage.dart';
import './components/secondPage.dart';
import './components/firstPage.dart';
import './components/forthPage.dart';
import 'package:firebase/firebase.dart';

void main() {
  // before using firebase you must import script in web/index.html
  initializeApp(
    apiKey: "AIzaSyBdz6ZbIFA5vbrLRoyQudWntdbS0g-YhjQ",
    authDomain: "lucky-draw-251307.firebaseapp.com",
    databaseURL: "https://lucky-draw-251307.firebaseio.com",
    projectId: "lucky-draw-251307",
    storageBucket: "",
  );

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
      '/third': (context) => DrawPage(),
      '/forth': (context) => ForthPage(),
    },
  ));
}
