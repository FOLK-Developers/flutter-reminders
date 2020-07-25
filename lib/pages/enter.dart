import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Enter extends StatefulWidget {
  @override
  _EnterState createState() => _EnterState();
}

class _EnterState extends State<Enter> {

  final lController = TextEditingController();
  final kController = TextEditingController();
  String place, kitchen;
  DateTime startdate;


  createdata()
  {
    DocumentReference documentReference = Firestore.instance.collection('location').document(place);
    Map<String, dynamic> fields= <String, dynamic>  {"kitchen":kitchen,"started": startdate};

    if(place != null && startdate != null && kitchen != null)
    {
      documentReference.setData(fields).whenComplete(() =>  alertbox('Confirmation','Data added successfully.')).catchError((e){
        alertbox('ERROR', 'COULD NOT COMPLETE ADD OPERATION\n'+e);
      });
    }
    else
    {
      alertbox('INCOMPLETE DETAILS','PLEASE FILL ALL THE DETAILS');
    }
  }


  AlertDialog alertbox(String alerttitle, String alertcontent)
  {
    Widget okbutton= FlatButton(
        child: Text('OK'), onPressed: ()
    {
      Navigator.pop(context);
    }
    );

    AlertDialog alert = AlertDialog(
      title: Text(alerttitle),
      content: Text(alertcontent),
      actions:[okbutton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context){
          return alert;}
    );

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[500],
      appBar: AppBar(
        title: Text('ADD / UPDATE'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SafeArea(
          child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
              Container(
                  height: 30.0,
                  width: 120.0,
                  margin: EdgeInsets.all(10.0),
                  color: Colors.brown[100],
                  alignment: Alignment.center,
                  child: Text('LOCATION', style: TextStyle(fontSize: 20))),
              Container(
                height: 35.0,
                width: 200.0,
                color: Colors.green[100],
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: lController,
                    onChanged: (String s) {
                      setState(() {
                        place = lController.text;
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 30.0,
                width: 180.0,
                color: Colors.brown[100],
                alignment: Alignment.center,
                margin: EdgeInsets.all(10.0),
                child: Text('DATE OF START', style: TextStyle(fontSize: 20)),
              ),
              Container(
                  height: 150.0,
                  color: Colors.green[100],
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime(2010, 9, 15),
                    onDateTimeChanged: (DateTime ndt) {
                      setState(() {
                        startdate=ndt;
                      });
                    },
                  )
              ),
              Container(
                height: 30.0,
                width: 160.0,
                color: Colors.brown[100],
                alignment: Alignment.center,
                margin: EdgeInsets.all(10.0),
                child: Text('KITCHEN TYPE',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                height: 35.0,
                width: 200.0,
                color: Colors.green[100],
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: kController,
                    onChanged: (String a) {
                      setState(() {
                        kitchen = kController.text;
                      });
                    },
                  ),
                ),
              ),
              Container(
                  width: 350.0,
                  height: 150.0,
                  margin: EdgeInsets.symmetric(vertical : 30.0, horizontal: 10.0 ),
                  color: Colors.orange[100],
                  child: Text('!!! PLEASE CHECK AGAIN:\n\nCITY : $place\nDATE : $startdate\nKITCHEN TYPE : $kitchen',
                      style: TextStyle(fontSize: 15))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.orange,
                    child: Text('CONFIRM'),
                    elevation: 5.0,
                    onPressed: createdata,
                  ),
                  RaisedButton(
                      color: Colors.teal,
                      child: Text('BACK'),
                      elevation: 5.0,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ],
          )
      ),
    );
  }
}