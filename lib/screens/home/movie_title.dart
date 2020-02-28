import 'package:ProjectXO/model/Movie.dart';
import 'package:ProjectXO/model/project.dart';
import 'package:flutter/material.dart';

class MovieTitle extends StatelessWidget {
  
  final Movie movie;
  MovieTitle({this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsetsDirectional.fromSTEB(20.0, 6.0, 20.0,0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.yellow[100],
            backgroundImage: AssetImage('assets/logo.png'),
          ),
          title: Text(movie.username),
          subtitle: Text('mail:${movie.email}'),
        ),
      ),
    );
  }
}


