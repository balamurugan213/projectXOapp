
import 'dart:async';
import 'dart:async';

import 'package:ProjectXO/screens/authenticate/formpage.dart';
import 'package:ProjectXO/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ProjectXO/model/user.dart';
import 'package:ProjectXO/screens/wrapper/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //User u1=new User();

  //create User object
  User userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid:user.uid) : null;
  }

  User userFromFirebaseUserr(User user){
   
    return user != null ? user : null;
  }
  


  

  //auth change in stream
  Stream<User> get user{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => userFromFirebaseUser(user));
    //.map(_userFromFirebaseUser(user));
  }
  

  //sign in anon
  Future signInAnon () async{
    try{
      AuthResult result=  await  _auth.signInAnonymously();
      FirebaseUser user=result.user;
      return userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //sign in wit id
  Future signInWithEmailPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);
      FirebaseUser user=result.user;
      return userFromFirebaseUser(user);

    }
    catch(e){
      print(e.toString());
      return null;

    }
  }


  //register
  Future registerWithEmailPassword(String name, String city, String phone, String userName, String email,String password ,bool investor,bool developer,bool innovator) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password: password);
      //return FormPage(userName,email,result: result);
      FirebaseUser user=result.user;
      await DatabaseService(uid: user.uid).updateUserData( name, city, phone,userName, email, investor, developer, innovator);
      return userFromFirebaseUser(user);

    }
    catch(e){
      print(e.toString());
      return null;

    }
  }

 //formvalidate
  Future formField(String name, String city, String phone, String userName, String email,bool investor,bool developer,bool innovator,User user) async{
    try{
      print(" func woeking");
      //print(user.uid);
      print(user.uid);
      await DatabaseService(uid: user.uid).updateUserDataForm(name, city, phone,userName, email, investor, developer, innovator);
      return "updated";
      //final user = Provider.of<User>(context);

    }
    catch(e){
      print(e.toString());
      return null;

    }
  }

  //sign out
  Future SignOut() async{
    try{
      
      return await _auth.signOut();

    }
    catch(e){
      print(e.toString());
      return null;

    }
    
  }


}


