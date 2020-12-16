import 'package:flutter/material.dart';
import 'package:helloCoffee/models/user.dart';
import 'package:helloCoffee/services/database.dart';
import 'package:helloCoffee/shared/constants.dart';
import 'package:helloCoffee/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your coffee settings',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a name' : null,
                  onChanged: (value) {
                    setState(() {
                      _currentName = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentSugars = value;
                    });
                  },
                ),
                //slider
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  activeColor: Colors.brown[userData.strength],
                  inactiveColor: Colors.brown[userData.strength],
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _currentStrength = value.round();
                    });
                  },
                ),
                RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentStrength ?? userData.strength,
                          _currentName ?? userData.name);
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.pinkAccent[400],
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
