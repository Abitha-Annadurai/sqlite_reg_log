import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflitetask/screens/signup.dart';
import '../db/SQLHelper.dart';
import 'Home.dart';

class Login_Form extends StatefulWidget {
  final data;
  const Login_Form({Key? key, this.data}) : super(key: key);

  @override
  State<Login_Form> createState() => _Login_FormState();
}

class _Login_FormState extends State<Login_Form> {
  Future<SharedPreferences> pref = SharedPreferences.getInstance();

  var formkey = GlobalKey<FormState>();
  final TextEditingController conemail = TextEditingController();
  final TextEditingController conpass = TextEditingController();

  List<dynamic> _users = [];

  get data => data;

  void _allUsers() async {
    final data = await SQLHelper.getAll();
    setState(() {
      _users = data;
      print(_users);
    });
  }

  @override
  void initState() {
    _allUsers();
    super.initState();
  }

  Future _checkUser(String email, String password) async {
    final existingUser = _users.firstWhere((element) =>
    element['email'] == email && element['password'] == password);
    print(existingUser);
    if (existingUser == null) {
      setState(() {
        //_error = "Invalid UserId / password";
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid Mailid / Password!'),
      ));
    }
    // print(existingUser['name']);
    print(existingUser);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", true);
    prefs.setString("name", existingUser['name']);
    prefs.setInt("id", existingUser['id']);
    prefs.setString("mobileno", existingUser['mobileno']);
    prefs.setString("mailid", existingUser['mailid']);
    prefs.setString("password", existingUser['password']);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Home(data: data,)));
    //_allUsers();
  }


  /*Future logincheck(String email, String password) async {
    if (email == 'admin@gmail.com' && password == '123456') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHome()));
    } else {
      var data = await SQLHelper.CheckLogin(email, password);
      if (data.isNotEmpty) {
        final existingUser = _users.firstWhere((element) => element['email'] == email && element['password'] == password);
        if (existingUser == null) {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Mailid / Password!'),
          ));

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("login", true);
          prefs.setInt("id", existingUser['id']);
          prefs.setString("email", existingUser['email']);
          prefs.setString("password", existingUser['password']);
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(data: data,)));
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(data: data,)));
        print('Login Success');
      } else if (data.isEmpty) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Signup()));
        print('Login faild');
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    bool hidepass = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN PAGE"),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Login Page",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: conemail,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.drive_file_rename_outline),
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                validator: (text) {
                  if (text!.isEmpty ||
                      !text.contains('@') ||
                      !text.contains(".")) {
                    return "Enter valid Email!!!";
                  }
                },
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: conpass,
                  obscureText: hidepass,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (hidepass)
                            hidepass = false;
                          else
                            hidepass = true;
                        });
                      },
                      icon: Icon(
                          hidepass ? Icons.visibility : Icons.visibility_off),
                    ),
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (pass) {
                    if (pass!.isEmpty || pass.length < 6) {
                      return "Password length should be greater than 6";
                    }
                  },
                  textInputAction: TextInputAction.next,
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                color: Colors.pink,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  final valid = formkey.currentState!.validate();

                  if (valid) {
                    _checkUser(conemail.text, conpass.text);
                  } else {}
                },
                child: const Text("LOGIN"),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup_Form()));
                },
                child: const Text('Not a User? Register Here!!!'))
          ],
        ),
      ),
    );
  }
}
