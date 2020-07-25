import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './pages/results.dart';
import './pages/enter.dart';
import './pages/alarm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp( home: new MainScreen());
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.brown[300],
      appBar: AppBar(
        title: Text('AKSHAYPATRA'),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
                color: Colors.orange,
                child: Text('ENTER NEW DATA OR UPDATE EXISTING', style: TextStyle(fontSize: 15),),
                elevation: 5.0,
                onPressed:()
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Enter()));
                }
            ),
            RaisedButton(
              color: Colors.green[300],
              child: Text('SHOW ALL RECORDS',style: TextStyle(fontSize: 15),),
              elevation: 5.0,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Rset()));
              },
            ),
            RaisedButton(
                color: Colors.indigo[400],
                child: Text('SET ALARM', style: TextStyle(fontSize: 15),),
                elevation: 5.0,
                onPressed:()
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Alarm()));
                }
            ),
          ],
        ),
      ),
    );
  }
}