import 'dart:async'; 

import 'home.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

void main() {
  dev.log('log me', name: 'my.app.category');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,        
       theme: ThemeData(fontFamily: 'avenir'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), openOnBoard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: InkWell(
            onTap: openOnBoard,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/image/logosapp.jpg'),
            ),
          ),
          //child: Text("Logo du college sabil"),
        ),
      )),
    );
  }

  void openOnBoard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Onboarding()));
  }
}
