import 'dart:io';

import 'package:ProjectXO/model/project.dart';
import 'package:ProjectXO/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ProjectXO/model/Movie.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection referance
  final CollectionReference mcollection = Firestore.instance.collection("user");
  final CollectionReference pcollection = Firestore.instance.collection("project");

  Future updateUserData(String name,String city,String phone,String username, String email,bool investor,bool developer,bool innovator) async{

    return await mcollection.document(uid).setData({
      'Name':name,
      'City':city,
      'Phone':phone,
      'Username':username,
      'E-mail':email,
      'Investor':investor,
      'Developer':developer,
      'Innovator':innovator,
    });
  }

  Future updateProData( String proname,String domain,String description) async{
    return await pcollection.document(uid).setData(
      {
     // 'pid':pid,
      'ProName':proname,
      'Domain':domain,
      'Description':description,
    });
  }

  Future updateUserDataForm(String name,String city,String phone,String username, String email,bool investor,bool developer,bool innovator) async{
    return await mcollection.document(uid).setData({
      'Name':name,
      'City':city,
      'Phone':phone,
      'Username':username,
      'E-mail':email,
      'Investor':investor,
      'Developer':developer,
      'Innovator':innovator,
      
      });
  }

//movie list from Snapshot
List<Movie> _movieListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map((doc){
    return Movie(
      username: doc.data['Username'] ?? '',
      email: doc.data['E-mail'] ?? ''     
    );
  }).toList();
}


//user data from snapshot
UserData _userDataFromSnapShot(DocumentSnapshot snapshot){
  return UserData(
    username: snapshot.data['Username'],
    email: snapshot.data['E-mail'],
    innovator: snapshot.data['Innovator'],
    investor: snapshot.data['Investor'],
    developer: snapshot.data['Developer'],
    name: snapshot.data['Name'],
    city: snapshot.data['City'],
    phone: snapshot.data['Phone'],
  );
}


//Project _proDataFromSnapShot(DocumentSnapshot snapshot){
 // return snapshot.map((doc){
  //return Project(
  //  pid: snapshot.data['pid'],
  //  proname: snapshot.data['proName'[pid]],
  //  desc: snapshot.data['Description'[pid]],
   // domain: snapshot.data['Domain'[pid]]
 // );
  
//}

List<Project> _proaListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map((doc){
    return Project(
    //pid: doc.data['pid'],
    proname: doc.data['ProName'] ?? '',
    desc: doc.data['Description'] ?? '',
    domain: doc.data['Domain']  ?? '' 
    );
  }).toList();
}

//get stream
Stream<List<Movie>> get movie {
  return mcollection.snapshots()
  .map(_movieListFromSnapshot);
}

//get user doc
Stream<UserData> get userData {
  return  mcollection.document(uid).snapshots()
  .map(_userDataFromSnapShot);
}

//Stream<Project> get projects {
 // return  pcollection.document(uid).snapshots()
 // .map(_proDataFromSnapShot);
//}

Stream<List<Project>> get project {
  return pcollection.snapshots()
  .map(_proaListFromSnapshot);
}

UserDataa _userDataFromSnapShott(DocumentSnapshot snapshot){
  return UserDataa(
    //uid: uid,
    username: snapshot.data['Username'],
    email: snapshot.data['E-mail'],
    innovator: snapshot.data['Innovator'],
    investor: snapshot.data['Investor'],
    developer: snapshot.data['Developer'],
    //email: snapshot.data['E-mail'],
  );
}
Stream<UserDataa> get userDataa {
  return  mcollection.document(uid).snapshots()
  .map(_userDataFromSnapShott);

}
}