import 'package:ProjectXO/model/Movie.dart';
import 'package:ProjectXO/model/project.dart';
import 'package:ProjectXO/screens/home/movie_list.dart';
import 'package:ProjectXO/screens/home/pro_list.dart';
import 'package:ProjectXO/screens/home/setting_form.dart';
import 'package:ProjectXO/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ProjectXO/service/database.dart';


class Home extends StatefulWidget {
 @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth =AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanal(){
      showModalBottomSheet(context: context,builder:(context){
        return Container(
          color: Colors.yellow[100],
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingssForm()
        );
      });
    }

    return StreamProvider<List<Project>>.value(
        value: DatabaseService().project,
        child:  Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/camera.png'),
            fit: BoxFit.cover,
            )
          ),
          child: Pro()
          ),
      );
  }
}