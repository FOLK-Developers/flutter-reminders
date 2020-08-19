import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addalarm extends StatefulWidget {
  @override
  _addalarmState createState() => _addalarmState();
}

class _addalarmState extends State<addalarm> {
  List<bool> weekdays = List.filled(7, false);
  TimeOfDay timeOfDay;
  String alarmnote;
  int everymonthon = 1, inmonth = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ADD A REMINDER'),
          backgroundColor: Colors.indigo,
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Card(
                color: Colors.orange[100],
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'DAILY',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'ALARM NOTE'),
                        onChanged: (note) => alarmnote = note,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Tap the Clock to pick time:'),
                      IconButton(
                        icon: Icon(Icons.alarm),
                        iconSize: 100.0,
                        color: Colors.blue[800],
                        onPressed: tod,
                      ),
                      FlatButton(
                        color: Colors.blueGrey[900],
                        child: Text(
                          'ADD',
                          style: TextStyle(color: Colors.orange[100]),
                        ),
                        onPressed: registerdailyalarm,
                      )
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.orange[200],
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'WEEKLY',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'ALARM NOTE'),
                        onChanged: (note) => alarmnote = note,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Select Days: '),
                      WeekdaySelector(
                        onChanged: (int day) {
                          setState(() {
                            weekdays[day % 7] = !weekdays[day % 7];
                          });
                        },
                        values: weekdays,
                        selectedFillColor: Colors.green[400],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Tap the Clock to pick time:'),
                      IconButton(
                        icon: Icon(Icons.alarm),
                        iconSize: 100.0,
                        color: Colors.blue[800],
                        onPressed: tod,
                      ),
                      FlatButton(
                        color: Colors.blueGrey[900],
                        child: Text(
                          'ADD',
                          style: TextStyle(color: Colors.orange[200]),
                        ),
                        onPressed: registerweeklyalarm,
                      )
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                color: Colors.orange[300],
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'MONTHLY',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'ALARM NOTE'),
                        onChanged: (note) => alarmnote = note,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            color: Colors.blue[100],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Date: '),
                                NumberPicker.integer(
                                    initialValue: everymonthon,
                                    minValue: 1,
                                    maxValue: 31,
                                    onChanged: (newValue) {
                                      setState(() {
                                        everymonthon = newValue;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text('Tap the Clock to pick time:'),
                              IconButton(
                                icon: Icon(Icons.alarm),
                                iconSize: 100.0,
                                color: Colors.blue[800],
                                onPressed: tod,
                              ),
                            ],
                          ),
                        ],
                      ),
                      FlatButton(
                        color: Colors.blueGrey[900],
                        child: Text(
                          'ADD',
                          style: TextStyle(color: Colors.orange[100]),
                        ),
                        onPressed: registermonthlyalarm,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.orange[400],
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'YEARLY',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'ALARM NOTE',
                        ),
                        onChanged: (note) => alarmnote = note,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            color: Colors.green[100],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Month :'),
                                NumberPicker.integer(
                                    initialValue: inmonth,
                                    minValue: 1,
                                    maxValue: 12,
                                    onChanged: (i) {
                                      setState(() {
                                        inmonth = i;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.green[100],
                            child: Column(
                              children: <Widget>[
                                Text('Date: '),
                                NumberPicker.integer(
                                    initialValue: everymonthon,
                                    minValue: 1,
                                    maxValue: 31,
                                    onChanged: (i) {
                                      setState(() {
                                        everymonthon = i;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Tap the Clock to pick time:'),
                      IconButton(
                        icon: Icon(Icons.alarm),
                        iconSize: 100.0,
                        color: Colors.blue[800],
                        onPressed: tod,
                      ),
                      FlatButton(
                        color: Colors.blueGrey[900],
                        child: Text(
                          'ADD',
                          style: TextStyle(color: Colors.orange[100]),
                        ),
                        onPressed: registeryearlyalarm,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void tod() {
    setState(() async {
      timeOfDay =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
    });
  }

  /*
  when real usernames are available,
  it may please be replaced
  by that variable
  i.e. phone or email
  to distinguish different users.
  */

  registerdailyalarm() {
    DocumentReference documentReference =
        Firestore.instance.collection('profile/username/reminders').document();

    Map<String, String> fields = <String, String>{
      'type': 'daily',
      'at': timeOfDay.toString(),
      'alarmnote': alarmnote
    };

    if (timeOfDay != null && alarmnote != null) {
      documentReference
          .setData(fields)
          .whenComplete(
              () => alertbox('Confirmation', 'Daily Alarm Added Successfully.'))
          .catchError((e) {
        alertbox('ERROR', 'COULD NOT COMPLETE ADD OPERATION\n' + e);
      });
    } else {
      alertbox('INCOMPLETE DETAILS', 'PLEASE FILL ALL THE DETAILS');
    }
  }

  registerweeklyalarm() {
    DocumentReference documentReference =
        Firestore.instance.collection('profile/username/reminders').document();

    Map<String, dynamic> fields = <String, dynamic>{
      'type': 'weekly',
      'alarmnote': alarmnote,
      'at': timeOfDay.toString(),
      'weekdays': weekdays
    };

    if (timeOfDay != null &&
        alarmnote != null &&
        weekdays.any((d) {
          return d == true;
        }))
    {
      documentReference
          .setData(fields)
          .whenComplete(
              () => alertbox('Confirmation', 'Weekly Alarm Added Successfully.'))
          .catchError((e) {
        alertbox('ERROR', 'COULD NOT COMPLETE ADD OPERATION\n' + e);
      });
    }
    else {
      alertbox('INCOMPLETE DETAILS', 'PLEASE FILL ALL THE DETAILS');
    }
  }

  registermonthlyalarm() {
    DocumentReference documentReference =
        Firestore.instance.collection('profile/username/reminders').document();

    Map<String, dynamic> fields = <String, dynamic>{
      'type': 'monthly',
      'alarmnote': alarmnote,
      'at': timeOfDay.toString(),
      'date': everymonthon
    };

    if (timeOfDay != null && alarmnote != null && everymonthon != null) {
      documentReference
          .setData(fields)
          .whenComplete(
              () => alertbox('Confirmation', 'Monthly Alarm Added Successfully.'))
          .catchError((e) {
        alertbox('ERROR', 'COULD NOT COMPLETE ADD OPERATION\n' + e);
      });
    } else {
      alertbox('INCOMPLETE DETAILS', 'PLEASE FILL ALL THE DETAILS');
    }
  }

  registeryearlyalarm() {
    DocumentReference documentReference =
        Firestore.instance.collection('profile/username/reminders').document();

    Map<String, dynamic> fields = <String, dynamic>{
      'type': 'yearly',
      'alarmnote': alarmnote,
      'at': timeOfDay.toString(),
      'date': everymonthon,
      'month': inmonth
    };

    if (timeOfDay != null &&
        alarmnote != null &&
        everymonthon != null &&
        inmonth != null) {
      documentReference
          .setData(fields)
          .whenComplete(
              () => alertbox('Confirmation', 'Yearly Alarm Added Successfully.'))
          .catchError((e) {
        alertbox('ERROR', 'COULD NOT COMPLETE ADD OPERATION\n' + e);
      });
    } else {
      alertbox('INCOMPLETE DETAILS', 'PLEASE FILL ALL THE DETAILS');
    }
  }

  AlertDialog alertbox(String alerttitle, String alertcontent) {
    Widget okbutton = FlatButton(
        child: Text('OK'),
        onPressed: () {
          Navigator.pop(context);
        });

    AlertDialog alert = AlertDialog(
      title: Text(alerttitle),
      content: Text(alertcontent),
      actions: [okbutton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
        );
  }
}
