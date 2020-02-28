import 'package:ProjectXO/model/project.dart';
import 'package:ProjectXO/screens/home/pro_title.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:ProjectXO/model/Movie.dart';

class Pro extends StatefulWidget {
  @override
  _ProState createState() => _ProState();
}

final controller =PageController();
class _ProState extends State<Pro> {
  
  @override
  Widget build(BuildContext context) {
final pro =Provider.of<List<Project>>(context);
    
    pro.forEach((pro){
      print(pro.proname);
     print(pro.domain);
     print(pro.desc);
   });
    return  ListView.builder(
      
      itemCount: pro.length,
      itemBuilder:(context,index) {
      return ProTitle(project: pro[index]);
     },
    );
  }
}
