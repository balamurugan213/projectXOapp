import 'package:ProjectXO/model/Movie.dart';
import 'package:ProjectXO/model/project.dart';
import 'package:flutter/material.dart';

class ProTitle extends StatelessWidget {
  
  
  final Project project;
  ProTitle({this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
            margin: EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
            color: Colors.yellow[100],
            child: ListTile(
            title:Text(
            project.proname,
            style: TextStyle(color: Colors.black,
            fontSize:30,
            fontWeight: FontWeight.w500),
            ),
            subtitle:Text(
            project.desc,
            style: TextStyle(color: Colors.black,
            fontSize: 20, fontWeight:FontWeight.w300
            
             ),
            ),
            
           ),
           ),
    );
  }
}


