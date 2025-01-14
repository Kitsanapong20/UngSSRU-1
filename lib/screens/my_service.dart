import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ung_ssru/screens/my_map.dart';
import 'package:ung_ssru/screens/show_product.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit การประกาศตัวแปล
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String nameString = '';
  Widget mywidget = ShowProduct();

  // Method
  Widget showInfo() {
    return ListTile(
      leading: Icon(Icons.info, color: Colors.blue[200], size: 36.0),
      title: Text(
        'Info',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget menuShowMap() {
    return ListTile(
      leading: Icon(Icons.place, color: Colors.blue[200], size: 36.0),
      title: Text(
        'Map',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget menuShowProduct() {
    return ListTile(
      leading: Icon(Icons.speaker_notes, color: Colors.blue[200], size: 36.0),
      title: Text(
        'Show Product',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      nameString = firebaseUser.displayName;
    });
    print('name = $nameString');
  }

  Widget showDrawerMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          headMenu(),
          menuShowProduct(),
          menuShowMap(),
          showInfo(),
          signOutAnExit(),
        ],
      ),
    );
  }

  Widget signOutAnExit() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        size: 36.0,
        color: Colors.red,
      ),
      title: Text(
        'Sign Out & Exit',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        mySignOut();
      },
    );
  }

  Future<void> mySignOut() async {
    await firebaseAuth.signOut().then((response) {
      exit(0);
    });
  }

  Widget headMenu() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, Colors.yellow[900]],
          radius: 1.5,
          center: Alignment.center,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 60.0,
            height: 60.0,
            child: Image.asset('images/logo.png'),
          ),
          Text(
            'Ung SSRU',
            style: TextStyle(
              color: Colors.green[800],
              fontSize: 24.0,
            ),
          ),
          Text('Login by $nameString')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: mywidget,
      drawer: showDrawerMenu(),
    );
  }
}
