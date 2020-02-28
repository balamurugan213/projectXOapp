//import 'dart:html';
import 'package:ProjectXO/model/shared/constant.dart';
import 'package:ProjectXO/model/shared/loding.dart';
import 'package:ProjectXO/model/user.dart';
import 'package:ProjectXO/screens/home/details.dart';
import 'package:ProjectXO/service/auth.dart';
import 'package:ProjectXO/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';


class FormPage extends StatefulWidget {

   final bool loading;
   FormPage({this.loading});
  //FormPage(String userName, String email, AuthResult result);
  
  @override
  _FormState createState() => _FormState();
}

enum SingingCharacter { innovatorr, developerr,investorr}

class _FormState extends State<FormPage> {

  
  


  final AuthService _auth =AuthService();
  final _formKey =GlobalKey<FormState>();
  
 

  bool loading=false;
  String name ='';
  String city='';
  String error = '';
  String phone='';
  bool investor=false;
  bool developer=false;
  bool innovator=true;
  SingingCharacter _character = SingingCharacter.innovatorr;

 // bool get loading => loading;
 //bool loadings= loading;
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserDataa>(
      stream: DatabaseService(uid:user.uid).userDataa,
      builder: (context, snapshot){
         UserDataa userDataa = snapshot.data;
        if(snapshot.hasData){
        return loading ?  Details() : Container(
           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
           child: Form(
             key: _formKey,
             child: ListView(
               children: <Widget>[
                 Column(
                   children: <Widget>[
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
                      /*Column(children: <Widget>[
                        ListTile(
                          title: const Text('Investor'),
                          leading:Radio(
                            value: SingingCharacter.investorr,
                            groupValue: _character,
                            onChanged: (SingingCharacter value){
                              innovator=true;
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
                              innovator=false;
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
                              innovator=false;
                              developer=false;
                              innovator=true;
                              setState(() {
                                _character = value;
                              });
                            },
                            )
                        )
                      ],
                      ),*/
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.grey[400],
                        child: Text("Sign Up",
                        style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                             //_auth.SignOut();
                            //setState(() => loading = true);
                            // print(" func woeking");
                            //print(email);
                           // print(password);
                            dynamic resultt = await _auth.formField(name, city, phone, userDataa.username,userDataa.email,userDataa.innovator,userDataa.developer,userDataa.investor,user);
                           //  print(" func woeking");
                           if(resultt !=null){
                            // loading=true;
                           setState(() { 
                             setState(() => loading = true);
                            });
                           }
                           else{
                             error='please enter correct details';
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
           ),
   );
      }
      }
    );
  }
}
