import 'package:ProjectXO/model/shared/constant.dart';
import 'package:ProjectXO/model/shared/loding.dart';
import 'package:ProjectXO/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ProjectXO/model/user.dart';


class SettingsFormm extends StatefulWidget {
  @override
  _SettingsFormmState createState() => _SettingsFormmState();
}

class _SettingsFormmState extends State<SettingsFormm> {

  final _formkey= GlobalKey<FormState>();
  final List<String> sugar =['0','1','2',];
  //formvalue
  String _currentproName;
  String _currentproDomain;
  String _currentproDesc;
  String _currentSugar;
  String _currentproStack;
  bool start=true;
  bool commit=false;
  bool deployed=false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {

        UserData userData = snapshot.data;

        if(snapshot.hasData){
        return Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  
                  Text('Update the Details',
                  style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height:20.0,),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>val.isEmpty ?'Please enter project name' :null,
                    onChanged: (val) =>setState(() => _currentproName = val),
                  ),
                  SizedBox(height: 20.0,),

                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>val.isEmpty ? 'Domain':null,
                    onChanged: (val) =>setState(() => _currentproDomain = val),
                  ),
                  SizedBox(height: 20.0,),

                  //description
                  Container(
                     margin: EdgeInsets.all(8.0),
  // hack textfield height
                     padding: EdgeInsets.only(bottom: 40.0),
                     child: TextField(
                      maxLines: 99,
                      decoration: InputDecoration
                      (
                       hintText: "Project description!",
                       border: OutlineInputBorder(),
                      ),
                      onChanged: (val) =>setState(() => _currentproDesc = val),
                          ),
                    ) , 
                    SizedBox(height: 20.0,),
                    Container(
                     margin: EdgeInsets.all(8.0),
  // hack textfield height
                     padding: EdgeInsets.only(bottom: 40.0),
                     child: TextField(
                      maxLines: 99,
                      decoration: InputDecoration
                      (
                       hintText: "Project description!",
                       border: OutlineInputBorder(),
                      ),
                      onChanged: (val) =>setState(() => _currentproStack = val),
                      ),
                    ), 
                    SizedBox(height: 20.0,),
                  //dropDown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugar ?? 1,
                    items: sugar.map((sugar){
                      return DropdownMenuItem(
                      
                        value: sugar,
                        child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) =>setState(() => _currentSugar = val),
                  ),
                  /*Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.yellow[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.white,
                    
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged:(val) =>setState(() => _currentStrength = val.round()),
                   ),
                   */
                  SizedBox(height: 10.0,),
                  //slider
                  RaisedButton(
                    color: Colors.yellow[600],
                    child: Text(
                      'update',
                       style: TextStyle(color: Colors.white)
                    ),
                    onPressed: () async{
                      if(_formkey.currentState.validate()) {
                      //  await DatabaseService(uid: user.uid).updateuProData(_currentproName,_currentSugar,_currentproDomain,_currentproDesc,_currentproStack,start,commit,deployed
                         // );
                          Navigator.pop(context);
                      }


                    },
                  )
                ],

              ),
            ],
          ),
          
        );
        }
        else
        {
          return Loading();

        }
      }
    );
  }
}