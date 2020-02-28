import 'package:ProjectXO/model/user.dart';
import 'package:ProjectXO/screens/authenticate/formpage.dart';
import 'package:ProjectXO/screens/home/details.dart';
import 'package:ProjectXO/screens/home/home.dart';
import 'package:ProjectXO/screens/home/homeinno.dart';
import 'package:ProjectXO/screens/home/movie_title.dart';
import 'package:ProjectXO/service/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ProjectXO/model/Movie.dart';
import 'package:path/path.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

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

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  File _image;

  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();

    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final moviee =Provider.of<List<Movie>>(context) ?? [];

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
          print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
      
      String fileName = basename(_image.path);
       StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
       StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
       StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
       setState(() {
          print("Profile Picture uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
       });
    }
    double screenHeight = MediaQuery.of(context).size.height;
   // final moviee =Provider.of<List<Movie>>(context) ?? [];
    //orint(moviee.documents);
    //moviee.forEach((movie){
    //  print(movie.name);
    //  print(movie.sugars);
    //  print(movie.strength);
   // });
    return  StreamBuilder<UserData>(

      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;
        if(snapshot.hasData){
          name=userData.name;
          city=userData.city;
          //error = '';
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
        return Row(
          children: <Widget>[
            Container(
              //color: Colors.yellow[100],
              child: Expanded(
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                            height:50,
                          ),
                          Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment:Alignment.topLeft,
                                child:ClipOval(
                                  child:SizedBox(
                                    width: 100.0,
                                    height: 100.0,
                                    child:(_image!=null)?Image.file(
                                      _image,
                                      fit:BoxFit.fill)
                                    :Image.network(
                                      'https://picsum.photos/250?image=9',
                                      fit:BoxFit.fill,
                                      ),
                                    )
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.only(top:60.0),
                                child: IconButton(
                                  icon:Icon(
                                    Icons.camera,
                                    size:30.0,
                                  ),
                                  onPressed :(){
                                    getImage();
                                    uploadPic(context);
                                  }
                                ),  
                              )
                            ],
                            ),
                        SizedBox(height: 12.0),
                        Card(
                                    margin: EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
                                    color: Colors.yellow[300],
                                    child: ListTile(
                                       title:Text(
                                           "name",
                                            style: TextStyle(color: Colors.black,
                                            fontSize:30,
                                            fontWeight: FontWeight.w800),
                                            ),
                                            subtitle:Text(
                                            "email ID",
                                            style: TextStyle(color: Colors.black,
                                            fontSize: 20, fontWeight:FontWeight.w200
                                             ),
                                             ),
                                             leading: CircleAvatar(
                                              backgroundColor: Colors.white,
                                               child: Icon(
                                                 Icons.perm_identity,
                                                  color: Colors.black,
                                                ),
                                               radius: 40,
                                               ),
                                              ),
                                            ),
                                     Divider(
                                      height: 34,
                                      thickness: 2.0,
                                      color: Colors.yellow[400],
                                      indent: 80,
                                      endIndent: 80,
                                    ),
                                    Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TabBar(
              controller: _nestedTabController,
              indicatorColor: Colors.teal,
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.black54,
              isScrollable: true,
              tabs: <Widget>[
                    Tab(
                      text: "     Profile              ",
                    ),
                    Tab(
                      text: "               Projects     ",
                    ),
                    
              ],
            ),
            Container(
              height: screenHeight * 0.45,
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              child: TabBarView(
                    controller: _nestedTabController,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0), ),
                          //color: Colors.yellow,
                          child:Details(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),),
                          child: Homeq(),
                        //  child:Container(child: Column(children: buildChildren())),
                      ),
                    ],
              ),
            )
          ],
        )
                      ]
              ),
                  ],
                ),
            ),
            )
          ],
        );
      }
      }
    );
                        
   // ListView.builder(
      
     // itemCount: moviee.length,
    //  itemBuilder:(context,index) {
    //  return MovieTitle(movie: moviee[index]);
   //  },
   // );
  }
}

buildChildren() {
  var builder = [

    
  ];
  if (innovator) {
    builder.add(
      FloatingActionButton(
      onPressed: () {
        
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.green,
      )
      );
  }
  return builder;
}

