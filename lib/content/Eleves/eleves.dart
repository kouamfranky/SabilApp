import 'dart:io';
import 'dart:async';
import 'dart:convert';

//import 'dart:html';

import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:dio/dio.dart';
import 'package:sabilapp/api/Cours/Cours.dart';
import 'package:sabilapp/api/Eleves/Eleves.dart';
import 'package:sabilapp/api/constapi.dart';
import 'package:sabilapp/content/menu.dart';
import 'package:sabilapp/content/menu.dart';
import 'package:sabilapp/content/Eleves/EnvoieDevoir.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sabilapp/content/menu.dart';
import 'package:url_launcher/url_launcher.dart'; 
 
String maValue;
List<Cours> ListeCours = null;
List<Cours> ListeCours1 = null;
List<Cours> ListeCoursFilter = null;
int _id;
int _currentIndex = 0;
int _value = 1;
int ide;
int statusDel = -1;
int edit = 0;
String titreInit = "";
String competenceInit = "";
int heureInit = 1;

initialState() {
  edit = 0;
  titreInit = "";
  competenceInit = "";
  heureInit = 1;
}

List<Cours> parseCours(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Cours>((json) => Cours.fromJson(json)).toList();
}

Eleves eleves;

class ElevesHome extends StatefulWidget {
  final Eleves eleve;
  ElevesHome({@required this.eleve});
  @override
  State<StatefulWidget> createState() {
    eleves = eleve;
    return _EleveState();
  }
}

class _EleveState extends State<ElevesHome> {
  List<Cours> getListCours;
  Future<List<Cours>> getCours(http.Client client) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/cours'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    print(response.body[0]);

    getListCours = parseCours(response.body);
    print(getListCours[0].titre);
    setState(() {
      ListeCours = getListCours;
      ListeCoursFilter = getListCours;
      _currentIndex = 0;
    });
  }

  String _titre;
  String _competence;
  String _durree;
  var _searchview = new TextEditingController();

  String filterType = "today";
  DateTime today = new DateTime.now();
  String taskPop = "close";
  Cours _coursModel;
  @override
  Widget build(BuildContext context) {
    print("iiiiii index courant AVANT--------------------------");
    print("iiiiii index courant APRES--------------------------");
    print(_currentIndex);
    void openEnvoieDevoir() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EnvoieDevoir(eleve: eleves)));
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: SideDrawerEleves(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu_book_sharp, size: 20),
                      Text("    "),
                      Text(
                        "Cours",
                        style: TextStyle(fontSize: 18),
                      )
                    ]),
              ),
              Tab(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu_book_sharp, size: 20),
                      Text("    "),
                      Text(
                        "Devoir",
                        style: TextStyle(fontSize: 18),
                      )
                    ]),
              ),
            ],
          ),
          title: Text(eleves.nom + " " + eleves.prenom),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.send),
          backgroundColor: Colors.green,
          onPressed: () => {openEnvoieDevoir()},
        ),
        body: TabBarView(
          children: [
            Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0x96066fff).withOpacity(0.2),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: new TextField(
                          controller: _searchview,
                          decoration: InputDecoration(
                            hintText: " Search Cours",
                            hintStyle: new TextStyle(color: Colors.grey[200]),
                          ),
                          autofocus: false,
                          textAlign: TextAlign.left,
                          onChanged: (text) {
                            print("Value: $text");
                            setState(() {
                              ListeCours = ListeCoursFilter.where((element) =>
                                  element.titre
                                      .toLowerCase()
                                      .contains(text.toLowerCase())).toList();
                            });
                          },
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: (() {
                        switch (ListeCours) {
                          case null:
                            getCours(http.Client());
                            return Center(child: CircularProgressIndicator());
                          default:
                            return CoursList(
                              cours: ListeCours,
                            );
                        }
                      }()))
                ],
              ),
            ),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );

    /*   Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SideDrawerEleves(),
      appBar:  AppBar(
        
        title: Text('Kouam Franky brice'),
        backgroundColor: Color(0x96066fff),
        elevation: 0,
      ), 
      body: 
      Container(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.admin_panel_settings),
                    label: Text(
                      "Enseignant > Gestion Cours",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0x96066fff).withOpacity(0.2),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: new TextField(
                    controller: _searchview,
                    decoration: InputDecoration(
                      hintText: " Search Cours",
                      hintStyle: new TextStyle(color: Colors.grey[200]),
                    ),
                    autofocus: false,
                    textAlign: TextAlign.left,
                    onChanged: (text) {
                      print("Value: $text");
                      setState(() {
                        ListeCours = ListeCoursFilter.where((element) => element
                            .titre
                            .toLowerCase()
                            .contains(text.toLowerCase())).toList();
                      });
                    },
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 99, 0, 0),
                child: (() {
                  switch (ListeCours) {
                    case null:
                      getCours(http.Client());
                      return Center(child: CircularProgressIndicator());
                    default:
                      return CoursList(
                        cours: ListeCours,
                      );
                  }
                }()))
          ],
        ),
      ),
    );*/
  }

  onTabTapped(int index) {
    setState(() {
      print("----TAP index---------");
      print(index);
      _currentIndex = index;
    });

    openTaskPop() {
      taskPop = "open";
      setState(() {});
    }

    closeTaskPop() {
      taskPop = "close";
      setState(() {});
    }

    changeFilter(String filter) {
      filterType = filter;
      setState(() {});
    }
  }
}

class CoursList extends StatefulWidget {
  final List<Cours> cours;
  CoursList({Key key, this.cours}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CoursList();
  }
}

class _CoursList extends State<CoursList> {
  List<Cours> getListCours;

  Future<List<Cours>> getCourss(http.Client client) async {
    List<Cours> CoursClasse;
    final response = await client.get(
      Uri.parse(baseUrl + '/cours'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    print(response.body[0]);

    getListCours = parseCours(response.body);
    /*for (var i = 0; i < getListCours.length; i++) {
      if (getListCours[i]) {
      CoursClasse.add(getListCours[i]);
      }
    }*/
    print(getListCours[0].titre);
    setState(() {
      ListeCoursFilter = getListCours;
      ListeCours = getListCours;
    });
  }

  void openfile(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    Slidable taskWidget(Cours cours) {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.20,
        closeOnScroll: true,
        child: Container(
          height: 90,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                offset: Offset(0, 9),
                blurRadius: 20,
                spreadRadius: 1)
          ]),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  openfile(cours.file);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  //height: 45,
                  //width: 45,
                  /* decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 4)),*/
                  child: Icon(
                    Icons.file_present,
                    color: Colors.blueGrey,
                    size: 40,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cours.titre,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(
                        cours.competence,
                        style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            fontSize: 17),
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            cours.type,
                            style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                                fontSize: 18
                                //backgroundColor: Colors.red
                                ),
                          ),
                          Text(
                            cours.durree.toString() + " h",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 5,
                color: Colors.blue[600],
              )
            ],
          ),
        ),
      );
    }

    return ListView.builder(
        itemCount: widget.cours.length,
        itemBuilder: (context, int index) {
          if (widget.cours[index].titre != null) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  taskWidget(widget.cours[index]),
                ],
              ),
            );
          }
        });
  }
}
