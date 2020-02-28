import 'package:ProjectXO/model/shared/constant.dart';
import 'package:ProjectXO/model/shared/loding.dart';
import 'package:ProjectXO/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ProjectXO/model/user.dart';


class SettingssForm extends StatefulWidget {
  @override
  _SettingssFormState createState() => _SettingssFormState();
}

class _SettingssFormState extends State<SettingssForm> {


  final _formkey= GlobalKey<FormState>();
  final List<String> sugar =['0','1','2','3','4'];
  //formvalue
  String _currentproName;
  String _currentproDomain;
  String _currentproDesc;
  String _currentSugar;
  String _currentproStack;
  bool start=true;
  bool commit=false;
  bool deployed=false;
  int _currentproiD;
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
                  Text('Create new project',
                  style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height:20.0,),
                  TextFormField(
                    //initialValue: 'Name',
                    decoration: textInputDecoration.copyWith(hintText: 'Project ID'),
                    //validator: (val) =>val.isEmpty ? 5678 :null,
                    onChanged: (val) =>setState(() => _currentproiD = val as int),
                  ),
                  SizedBox(height:20.0,),
                  TextFormField(
                    //initialValue: 'Name',
                    decoration: textInputDecoration.copyWith(hintText: 'Project Name'),
                    validator: (val) =>val.isEmpty ?'Project' :null,
                    onChanged: (val) =>setState(() => _currentproName = val),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                      //  initialValue: userData.name,
                        decoration: textInputDecoration.copyWith(hintText: 'Domain'),
                        validator: (val) =>val.isEmpty ? 'Domain':null,
                        onChanged: (val) =>setState(() => _currentproDomain = val),
                      ),
                  SizedBox(height: 20.0,),
                  Container(
                        // margin: EdgeInsets.all(8.0),
                        // padding: EdgeInsets.only(bottom: 40.0),
                         child: TextFormField(
                          //initialValue: "description",
                          maxLines: 19,
                          decoration: textInputDecoration.copyWith(hintText: 'Description'),
                         // decoration:textInputDecoration.copyWith(hintText: 'Name'),
                          onChanged: (val) =>setState(() => _currentproDesc = val),
                              ),
                        ) , 
                  //dropDown
                 /* DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugar ?? userData.sugars,
                    items: sugar.map((sugar){
                      return DropdownMenuItem(
                      
                        value: sugar,
                        child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) =>setState(() => _currentSugar = val),
                  ),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.yellow[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.white,
                    
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged:(val) =>setState(() => _currentStrength = val.round()),
                   ),*/
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
                        await DatabaseService(uid: user.uid).updateProData(_currentproName, _currentproDomain ,_currentproDesc);
                          //_currentSugar ?? userData.sugars, 
                          //_currentName ?? userData.strength,
                         // _currentStrength ?? userData.strength
                      
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