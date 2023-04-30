import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:sqflitetask/screens/Home.dart';
import 'package:sqflitetask/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool checkLogin = pref.getBool('firstView') ?? false;
  runApp(Splash(checkLogin));
}

class Splash extends StatelessWidget {
  bool checkLogin;
  Splash(this.checkLogin, {Key? key}) : super(key: key);

  get data => data;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blueAccent,
      theme: ThemeData(primarySwatch: Colors.red),
      home: checkLogin ? Login_Form() : Home(data: data),
      //home: Login_Form(),
    );
  }
}

