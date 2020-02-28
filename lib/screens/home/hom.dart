import 'package:ProjectXO/model/Movie.dart';
import 'package:ProjectXO/model/project.dart';
import 'package:ProjectXO/screens/home/home.dart';
import 'package:ProjectXO/screens/home/pro_list.dart';
import 'package:ProjectXO/screens/home/profile.dart';
import 'package:ProjectXO/screens/home/prosetting_form.dart';
import 'package:ProjectXO/screens/home/prosetting_form.dart';
import 'package:ProjectXO/screens/home/setting_form.dart';
import 'package:ProjectXO/service/auth.dart';
import 'package:ProjectXO/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homee.dart';
import 'movie_list.dart';

class MyHomePagentb extends StatefulWidget {
  MyHomePagentb({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePagentb> with TickerProviderStateMixin {
  TabController _tabController;
  final AuthService _auth =AuthService();

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _showSettingsPanal(){
      showModalBottomSheet(context: context,builder:(context){
        return Container(
          color: Colors.yellow[100],
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: SettingssForm()
        );
      });
    }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Movie>>.value(
        value: DatabaseService().movie,
        child: Scaffold(
      appBar: AppBar(
        title: Text('yellow box'),
        backgroundColor: Colors.yellow[600],
        elevation: 0.0,
        actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'
              ),
              onPressed: () async{
                await _auth.SignOut();

              },
            ),
            FlatButton.icon(
             icon: Icon(Icons.settings),
              label: Text('Setting'),
              onPressed: () =>_showSettingsPanal()
            )
          ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.email),
              ),
              Tab(
                icon: Icon(Icons.settings),
              ),
            ]),
      ),
      body: TabBarView(
        children: <Widget>[
          Profile(),
          Home(),
          //NestedTabBar(),
          Center(
            child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/camera.png'),
            fit: BoxFit.cover,
            )
          ),
          child: Moviee()
          )
          )
        ],
        controller: _tabController,
      ),
     )
    );
  }
}