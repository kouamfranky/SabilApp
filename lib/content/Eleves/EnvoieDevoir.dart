import 'package:flutter/material.dart';
import 'package:sabilapp/api/Eleves/Eleves.dart'; 
import 'package:sabilapp/content/Eleves/eleves.dart';


Eleves eleves;

class EnvoieDevoir extends StatelessWidget {
  final Eleves eleve;
  EnvoieDevoir({@required this.eleve});
  @override
  Widget build(BuildContext context) {
    eleves=eleve;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: envoieDevoir(),
    );
  }
}

class envoieDevoir extends StatefulWidget {
  @override
  _envoieDevoirState createState() => _envoieDevoirState();
}

class _envoieDevoirState extends State<envoieDevoir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x96066fff),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: openBack,
        ),
        title: Text(
          "Envoyer un devoir",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.short_text,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: 30,
              color: Color(0x96066fff),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Colors.white),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.85,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.grey.withOpacity(0.1),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Title", border: InputBorder.none),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5))),
                            child: TextField(
                              maxLines: 6,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "ajouter une description",
                              ),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.attach_file,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color(0x96066fff)),
                            child: Center(
                              child: Text(
                                "Envoyer",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void openHomePage() {
   // Navigator.push(
    //    context, MaterialPageRoute(builder: (context) => HomePage()));
  }
 openBack() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ElevesHome(eleve: eleves,)));
  }
  void openEnvoieDevoir() {
  //  Navigator.push(
    //    context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
