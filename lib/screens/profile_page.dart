import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/SQLHelper.dart';
import 'login.dart';

class ProfilePage extends StatelessWidget {
  final data;

  const ProfilePage({Key? key, this.data}) : super(key: key);


  void delet(int id)async {
    await SQLHelper.Deleteuser(id);
  }

  void logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("login");
    pref.remove("email");
    pref.remove("password");
    pref.remove("id");
  }

  @override
  Widget build(BuildContext context) {
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
                        logOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Form()));
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
