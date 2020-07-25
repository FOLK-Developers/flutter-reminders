import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  DateTime alarmtime;
  final format = DateFormat('yyyy-MM-dd HH-mm');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (String payload) async { selectNotification(payload); });

    showNotification();
  }

  Future selectNotification(String payload) async{
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: const Text("Alert Title"),
        content: new Text("Alert Content: $payload"),
        actions: [
          FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context)
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[200],
      appBar: AppBar(
        title: new Text('SET ALARM'),
        backgroundColor: Colors.green[600],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            RaisedButton(
              color: Colors.green[300],
              padding: EdgeInsets.all(5.0),
              elevation: 5.0,
              child: Text('Alarm Once'),
              onPressed: (){},
            ),
            RaisedButton(
              color: Colors.green[200],
              child: Text('Daily Alarm'),
              onPressed: (){},
            ),
            RaisedButton(
              color: Colors.green[100],
              child: Text('Weekly Alarm'),
              onPressed: (){},
            ),

//            Text('Basic Date & Time Field (${format.pattern})'),

            Container(
              height: 100.0,
              color: Colors.green[100],
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (dt) {
                  setState(() {
                    alarmtime = dt;
                  });
                },
              ),
            ),

            Container(
              height: 50.0,
              width: 260.0,
              color: Colors.amber,
              child: Text(alarmtime.toString()??'NOT SET!!!',style: TextStyle(fontSize: 20),),
            ),
            RaisedButton(
              child: Text('Show Notification default sound'),
              onPressed: showNotification,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showNotification() async{
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails('Notification Channel ID', 'Channel Name', 'Description of the Channel', importance: Importance.Max, priority: Priority.High, timeoutAfter: 60000);

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, 'Notification Title', 'Notification details',alarmtime, platformChannelSpecifics, payload: 'Default_Sound');
  }
}