
import 'package:ProjectXO/model/user.dart';
import 'package:ProjectXO/screens/authenticate/authenticate.dart';
import 'package:ProjectXO/screens/authenticate/formpage.dart';
import 'package:ProjectXO/screens/home/hom.dart';
import 'package:ProjectXO/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  bool showForm=false;

  String get email => null;
  get result => null;
  String get userName => null;

  //void toggleForm(bool val){
  //  setState(() => showForm=val);
 // }
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    //print(user);

    //home or authenticate
   // return Authenticate();

   if (user == null){
     return Authenticate();
   }
   else{   
      //return Home();
      return MyHomePagentb();
   }   
  }
}