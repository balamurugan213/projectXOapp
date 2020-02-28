import 'package:ProjectXO/model/Movie.dart';
import 'package:ProjectXO/screens/home/movie_list.dart';
import 'package:ProjectXO/screens/home/setting_form.dart';
import 'package:ProjectXO/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ProjectXO/service/database.dart';


class Homeq extends StatefulWidget {
 @override
  _HomeqState createState() => _HomeqState();
}

class _HomeqState extends State<Homeq> {

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

    return StreamProvider<List<Movie>>.value(
        value: DatabaseService().movie,
        child:  Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Asset 2@2x.png'),
            fit: BoxFit.cover,
            )
          ),
          //child: Moviee()
          ),
      );
  }
}