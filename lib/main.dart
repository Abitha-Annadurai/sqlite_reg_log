import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflitetask/screens/Home.dart';
import 'package:sqflitetask/screens/login.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blueAccent,
      theme: ThemeData(primarySwatch: Colors.red),
      //home: checkLogin ? Login_Form() : Home(data: data),
      home: SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  final data;
  const SplashScreen({Key? key, this.data}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  get data => data;

  @override
  void initState(){
    super.initState();
    screenCheck();
  }

  void screenCheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var pageMove = pref.getBool("login") ?? false;
    if (pageMove == false) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login_Form()));
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home(data: data,)));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/11.jpg"),
          fit: BoxFit.cover
        )
      ),
    );
  }
}
