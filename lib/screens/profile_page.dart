import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/SQLHelper.dart';
import 'login.dart';
import 'login_signup.dart';

class ProfilePage extends StatelessWidget {
  final data;
   ProfilePage({Key? key,required this.data}) : super(key: key);

  //void _deleteItem(int id) async {
    //await SQLHelper.Deleteuser(id);
  //}

  void delet(int id)async {
    await SQLHelper.Deleteuser(id);
  }
  Future<SharedPreferences> pref = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {

    //var name  = data[0]['name'];
    //var email = data[0]['email'];
    //var password = data[0]['password'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile'),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,int index){
            return Container(
              child: Column(
                children: [
                  Text('${data[index]['name']}'),
                  Text('${data[index]['email']}'),
                  Text('${data[index]['password']}'),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){
                        delet(data[index]['id']);
                        Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, a, b) => Login_Form(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                                (route) => false);
                      },icon: Icon(Icons.delete),),
                      IconButton(onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        pref.remove("firstView");
                        Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, a, b) => Login_Signup(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                                (route) => false);
                      },icon: Icon(Icons.logout),),

                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
