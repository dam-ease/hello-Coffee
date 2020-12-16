import 'package:flutter/material.dart';
import 'package:helloCoffee/models/coffee.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  CoffeeTile({this.coffee});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/coffee_icon.png'),
              radius: 25,
              backgroundColor: Colors.brown[coffee.strength],
            ),
            title: Text(coffee.name),
            subtitle: Text('Takes ${coffee.sugars} sugar(s)'),
          ),
        ));
  }
}
