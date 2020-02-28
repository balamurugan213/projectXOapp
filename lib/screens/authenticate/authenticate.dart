//import 'dart:html';

import 'package:ProjectXO/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:ProjectXO/screens/authenticate/signin.dart';

class Authenticate extends StatefulWidget {

 // final Function toggleForm;
 // Authenticate({this.toggleForm});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn=true;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      //widget.toggleForm(false);
      return SignIn(toggleView:toggleView);
    }
    else{
      //widget.toggleForm(true);
      return Register(toggleView:toggleView);
    }
  }
}

