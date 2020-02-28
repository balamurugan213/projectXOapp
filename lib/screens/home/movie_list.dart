import 'package:ProjectXO/screens/home/movie_title.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:ProjectXO/model/Movie.dart';

class Moviee extends StatefulWidget {
  @override
  _MovieeState createState() => _MovieeState();
}

class _MovieeState extends State<Moviee> {
  @override
  Widget build(BuildContext context) {

    final moviee =Provider.of<List<Movie>>(context) ?? [];
    //orint(moviee.documents);
    //moviee.forEach((movie){
    //  print(movie.name);
    //  print(movie.sugars);
    //  print(movie.strength);
   // });
    return  ListView.builder(
      
      itemCount: moviee.length,
      itemBuilder:(context,index) {
      return MovieTitle(movie: moviee[index]);
     },
    );
  }
}
