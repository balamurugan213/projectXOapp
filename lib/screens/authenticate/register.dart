import 'package:ProjectXO/model/shared/constant.dart';
import 'package:ProjectXO/model/shared/loding.dart';
import 'package:ProjectXO/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

enum SingingCharacter { innovatorr, developerr,investorr}

class _RegisterState extends State<Register> {
  


  final AuthService _auth =AuthService();
  final _formKey =GlobalKey<FormState>();
   bool loading = false;


  String email ='';
  String password='';
  String error = '';
  String userName='';
  String name ='';
  String city='';
  String phone='';
  bool investor=false;
  bool developer=false;
  bool innovator=true;
  SingingCharacter _character = SingingCharacter.innovatorr;
  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
     backgroundColor: Colors.yellowAccent[50],
     appBar: AppBar(
       backgroundColor: Colors.yellow[600],
       elevation: 0.0,
       title: Text('Sign up to yellow box') ,
       actions: <Widget>[
         FlatButton.icon(
           icon: Icon(Icons.person),
           label: Text('Sign In'),
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
         child: ListView(
           children: <Widget>[
             Column(
               children: <Widget>[
                 SizedBox(height: 20.0),
                 TextFormField(
                   decoration:textInputDecoration.copyWith(hintText: 'Username'),
                   validator: (val) => val.isEmpty ? 'Enter Username':null,
                   onChanged: (val){
                     setState(() => userName=val);

                   }
                   
                 ),
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
                    decoration:textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'enter atleast 7 character':null,
                    onChanged: (val){
                     setState(() => password=val);

                   }
                  ),
                  SizedBox(height: 20.0),
                     TextFormField(
                       decoration:textInputDecoration.copyWith(hintText: 'Name'),
                       validator: (val) => val.isEmpty ? 'Name':null,
                       onChanged: (val){
                         setState(() => name=val);

                       }
                     ),
                     SizedBox(height: 20.0),
                     TextFormField(
                       decoration:textInputDecoration.copyWith(hintText: 'City'),
                       validator: (val) => val.isEmpty ? 'Enter City':null,
                       onChanged: (val){
                         setState(() => city=val);

                       }
                     ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:textInputDecoration.copyWith(hintText: 'Phone No'),
                        validator: (val) => val.length < 10 ? 'enter 10 character':null,
                        onChanged: (val){
                         setState(() => phone=val);

                       }
                      ),
                  SizedBox(height: 20.0),
                  Column(children: <Widget>[
                        ListTile(
                          title: const Text('Investor'),
                          leading:Radio(
                            value: SingingCharacter.investorr,
                            groupValue: _character,
                            onChanged: (SingingCharacter value){
                              investor=true;
                              developer=false;
                              innovator=false;
                              setState(() {
                                _character = value;
                              });
                            },
                            )
                        ),
                        ListTile(
                          title: const Text('Developer'),
                          leading:Radio(
                            value: SingingCharacter.developerr,
                            groupValue: _character,
                            onChanged: (SingingCharacter value){
                              investor=false;
                              developer=true;
                              innovator=false;
                              setState(() {
                                _character = value;
                              });
                            },
                            )
                        ),
                        ListTile(
                          title: const Text('Innovatorr'),
                          leading:Radio(
                            value: SingingCharacter.innovatorr,
                            groupValue: _character,
                            onChanged: (SingingCharacter value){
                              investor=false;
                              developer=false;
                              innovator=true;
                              setState(() {
                                _character = value;
                              });
                            },
                            )
                        )
                      ],
                      ),
                      SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.grey[400],
                    child: Text("Sign Up",
                    style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        //print(email);
                        //print(password);
                        dynamic result = await _auth.registerWithEmailPassword(name, city, phone,userName,email,password,innovator,developer,investor);
                        if(result == null){
                          setState(() { error='please enter a valid email';
                          setState(() => loading = false);
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red,fontSize:14.0),
                  )
               ],
             ),
           ],
         ),
       )
     ) ,
   );
  }
}