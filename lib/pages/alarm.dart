//import 'dart:html';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

//import 'package:intl/intl.dart';
import './addalarm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();
  DateTime alarmtime;
  String alertTitle = 'Alert Title',
      alertContent = 'Alert Content';
  List<bool> weekdays = List.filled(7, false);
  Time time;
  TimeOfDay timeOfDay;
  QuerySnapshot alarms;

  void initState() {
    fireconn().then((results) {
      setState(() {
        alarms = results;
      });
    });
    super.initState();
  }

  fireconn() async
  {
    return await Firestore.instance.collection('profile/username/reminders').getDocuments();
    //CollectionReference collectionReference = Firestore.instance.collection('location');
  }

  Widget alarmslist() {
    if (alarms != null) {
      return ListView.builder(
        itemCount: alarms.documents.length,
        padding: EdgeInsets.all(5.0),
        itemBuilder: (BuildContext context, int i) {
          return Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('${i + 1}) Alarm id : ' +
                      alarms.documents[i].documentID.toString(),
                    style: TextStyle(fontSize: 25),),
                  subtitle: Text(
                    'Alarmnote : ' + alarms.documents[i].data['alarmnote'] +
                        '\nType : ' +
                        alarms.documents[i].data['type'] + '\nScheduled for: '+alarms.documents[i].data['at'], style: TextStyle(fontSize: 20),),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 40.0,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Firestore.instance.collection('profile/username/reminders').document(
                          alarms.documents[i].documentID.toString()).delete();
                      fireconn().then((results) {
                        setState(() {
                          alarms = results;
                        });
                      });
                    },
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 0,
                ),
              ],
            ),
          );
        },
      );
    }
    else {
      return Text('LOADING... PLEASE WAIT');
    }
  }


//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
//    var initializationSettingsIOS = new IOSInitializationSettings();
//    var initializationSettings = new InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//
//    flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        onSelectNotification: (String payload) async {
//      selectNotification(payload);
//    });
//
//    showNotification();
//  }


  Future selectNotification(String payload) async {
    showDialog(
        context: context,
        builder: (_) =>
        new AlertDialog(
            title: Text(alertTitle),
            content: Text(alertContent + ': $payload'),
            actions: [
              FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context))
            ]
        )
    );
  }

  Future<void> showdailyNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'Notification Channel ID', 'Channel Name', 'Description of the Channel',
        importance: Importance.Max, priority: Priority.High);

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0, 'Notification Title', 'Notification details',
        Time(timeOfDay.hour, timeOfDay.minute, 0), platformChannelSpecifics,
        payload: 'Default_Sound');
  }

//  Future<void> showWeeklyNotification() async {
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//        'Notification Channel ID', 'Channel Name', 'Description of the Channel', importance: Importance.Max, priority: Priority.High);
//
//    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//
//    var platformChannelSpecifics = new NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//
//    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(0, 'Notification Title', 'Notification details', weekdays, time, platformChannelSpecifics, payload: 'Default_Sound');
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        title: new Text('ALARMS'),
        backgroundColor: Colors.green[600],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => addalarm()));
            }, //selectAlarmType,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              fireconn().then((results){
                setState(() {
                  alarms = results;
                });
              });
            },
          )
        ],
      ),
      body: alarmslist(),
    );
  }

  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'Notification Channel ID', 'Channel Name', 'Description of the Channel',
        importance: Importance.Max, priority: Priority.High);

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0, 'Notification Title', 'Notification details', alarmtime,
        platformChannelSpecifics, payload: 'Default_Sound');
  }
}