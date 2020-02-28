import 'package:ProjectXO/model/shared/constant.dart';
import 'package:ProjectXO/model/shared/loding.dart';
import 'package:ProjectXO/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  

  final AuthService _auth =AuthService();
  final _formKey =GlobalKey<FormState>();
  bool loading = false;

  String email ='';
  String password='';
  String error = '';


  
  @override
  Widget build(BuildContext context) {
   return loading ? Loading() : Scaffold(
     backgroundColor: Colors.yellowAccent[50],
     appBar: AppBar(
       backgroundColor: Colors.yellow[600],
       elevation: 0.0,
       title: Text('Sign in to yellow box') ,
       actions: <Widget>[
         FlatButton.icon(
           icon: Icon(Icons.person),
           label: Text('Register'),
           onPressed: () {
             widget.toggleView();

           },
         )
       ],
     ),
     body: Container(
       padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
       child: Form(
         key: _formKey,
         child: Column(
           children: <Widget>[
             SizedBox(height: 20.0),
             TextFormField(
               decoration:textInputDecoration.copyWith(hintText: 'Email'),
               validator: (val) => val.isEmpty ? 'Enter mail':null,
               onChanged: (val){
                 setState(() => email=val);

               }
             ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length <6 ? 'enter atleast 7 character':null,
                obscureText: true,
               onChanged: (val){
                 setState(() => password=val);

               }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.grey[400],
                child: Text("Sign In",
                style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  //print(email);
                  //print(password);
                  setState(() =>loading=true);
                  if(_formKey.currentState.validate()){
                    setState(() =>loading=true);
                    dynamic result = await _auth.signInWithEmailPassword(email, password);
                    if(result==null){
                      setState(() { 
                        error='please enter a valid email or password';
                        loading = false;
                      });
                   }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize:14.0),
              )
           ],
         ),
       )
       /* RaisedButton(
         child: Text("Sing in anom"),
         onPressed: () async {
           dynamic result = await _auth.signInAnon();
           if(result== null){
             print('error in sign in');
           }
           else{
             print('signed in');
             print(result.uid);
           }

         } ,
       ),*/
     ) ,
   );
  }
}