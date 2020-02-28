import 'package:ProjectXO/model/shared/constant.dart';
import 'package:ProjectXO/model/shared/loding.dart';
import 'package:ProjectXO/model/user.dart';
import 'package:ProjectXO/screens/authenticate/formpage.dart';
import 'package:ProjectXO/service/auth.dart';
import 'package:ProjectXO/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';


class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}
  String type='';
  String name ='';
  String city='';
  String error = '';
  String phone='';
  bool investor=false;
  bool developer=false;
  bool innovator=true;
  final bool loadings=false;

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot){
         UserData userData = snapshot.data;
        if(snapshot.hasData){
          name=userData.name;
          city=userData.city;
          phone=userData.phone;
          investor=userData.investor;
          developer=userData.developer;
          innovator=userData.innovator;
          if(investor){
            type="Investor";
          }
          else if(innovator){
            type="Innovator";
          }
          else{
            type="Developer";
          }
        return Container(
          color: Colors.yellow[100],
          child:Padding(
      padding: EdgeInsets.only(top: 8.0),
      
      child: ListView(
        children: <Widget>[
          Card(
        margin: EdgeInsetsDirectional.fromSTEB(20.0, 6.0, 20.0,0.0),
        child: ListTile(
          //leading: CircleAvatar(
           // radius: 25.0,
           // backgroundColor: Colors.yellow[100],
           // backgroundImage: AssetImage('assets/logo.png'),
        // ),
          title: Text(type,
          style: TextStyle(color: Colors.black,
          fontSize:30,
          fontWeight: FontWeight.w800)
                                        )
         // subtitle: Text("City"),
        ),
      ),
          Card(
            margin: EdgeInsetsDirectional.fromSTEB(20.0, 6.0, 20.0,0.0),
            child: ListTile(
              title: Text(name),
              subtitle: Text("Name"),
            ),
          ),
       Card(
        margin: EdgeInsetsDirectional.fromSTEB(20.0, 6.0, 20.0,0.0),
        child: ListTile(
         // leading: CircleAvatar(
         //   radius: 25.0,
          //  backgroundColor: Colors.yellow[100],
          //  backgroundImage: AssetImage('assets/logo.png'),
        //  ),
          title: Text(city),
          subtitle: Text("City"),
        ),
      ),
      Card(
        margin: EdgeInsetsDirectional.fromSTEB(20.0, 6.0, 20.0,0.0),
        child: ListTile(
          title: Text(phone),
          subtitle: Text("Phone"),
        ),
      ),
      ],
      ),
    )
    );      
  } 
  }
 );
 }
}