import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/services.dart';
//import './enter.dart';

class Rset extends StatefulWidget {
  @override
  _RsetState createState() => _RsetState();
}

class _RsetState extends State<Rset> {

//  CollectionReference collectionReference = Firestore.instance.collection('location');
  QuerySnapshot locations;

  fireconn() async
  {
    return await Firestore.instance.collection('location').getDocuments();

    //CollectionReference collectionReference = Firestore.instance.collection('location');
  }

  void initState()
  {
    fireconn().then((results){
      setState(() {
        locations = results;
      });
    });
    super.initState();
  }


  Widget locationlist()
  {
    if (locations != null) {
      return ListView.builder(
        itemCount: locations.documents.length,
        padding: EdgeInsets.all(5.0),
        itemBuilder: (BuildContext context,int i){
          return new ListTile(
            title:Text('${i+1}) City : ' + locations.documents[i].documentID.toString(), style: TextStyle(fontSize: 25),),
            subtitle: Text('Kitchen : '+locations.documents[i].data['kitchen'] + '\nStarted On : ' + locations.documents[i].data['started'].toDate().toString().substring(0,10), style: TextStyle(fontSize: 20),),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                size: 40.0,
                color: Colors.black,
              ),
              onPressed: (){
                Firestore.instance.collection('location').document(locations.documents[i].documentID.toString()).delete();
                fireconn().then((results){
                  setState(() {
                    locations = results;
                  });
                });
              },
            ),
          );
        },
      );
    }
    else {
      return Text('LOADING... PLEASE WAIT');
    }
  }

  @override
  Widget build(BuildContext context) {

//  ListView resultlist= new ListView();

    return Scaffold(
        backgroundColor: Colors.yellow[100],
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: Text('SEARCH RESULTS', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){
                fireconn().then((results){
                  setState(() {
                    locations = results;
                  });
                });
              },
            )
          ],
        ),
        body:locationlist(),
    );
  }
}
