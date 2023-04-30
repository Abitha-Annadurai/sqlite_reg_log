import 'package:flutter/material.dart';
import 'package:sqflitetask/screens/login.dart';

void main() async {
  runApp(Splash());
}

class Splash extends StatelessWidget {
  Splash({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blueAccent,
      theme: ThemeData(primarySwatch: Colors.red),
      //home: checkLogin ? Login_Form() : Home(data: data),
      home: Login_Form(),
    );
  }
}

