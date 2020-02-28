import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class User 
{

  final String uid;
  User({ this.uid});

 // get Stream => null;
  
}

class UserData {
  //final String uid;
  final String username;
  final String email;
  final String name;
  final String city;
  final String phone;
  final bool investor;
  final bool developer;
  final bool innovator;

  UserData({this.username,this.email,this.name,this.city,this.phone,this.innovator,this.developer,this.investor
  });


}

class UserDataa {
  final String uid;
  final String username;
  final String email;
  final bool investor;
  final bool developer;
  final bool innovator;

  UserDataa({ this.uid,this.username,this.email,this.innovator,this.developer,this.investor
  });

}