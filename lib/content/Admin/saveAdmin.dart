import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sabilapp/content/menu.dart';

class SaveAdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawerAdmin(),
      appBar: AppBar(
        title: Text('Kouam Franky brice'),
        backgroundColor: Color(0x96066fff),
        elevation: 0,
      ),
      body:  Text("------------------------------")
    );
  }
}
class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(random.nextInt(300), random.nextInt(300),
        random.nextInt(300), random.nextInt(300));
  }
}