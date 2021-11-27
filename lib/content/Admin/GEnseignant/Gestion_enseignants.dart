import 'dart:async';
import 'dart:convert';

import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sabilapp/api/Other/Administrateur.dart';
import 'package:sabilapp/content/cours.dart';
import 'package:sabilapp/content/menu.dart';

String maValue;
List<Cours> ListeCours = null;
int _id = ListeCours.length;

int _currentIndex = 0;
int _value = 1;
int ide;
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

Future<List<Cours>> fetchCours() async {
  final response = await rootBundle.loadString('asset/json/cours.json');
  return compute(parseCours, response);
}
/*
Future<List<Cours>> fetchCours(http.Client client) async {
  print("--------------- fffffffffffffffffdddddddddd -------------");
  final response = await client.get('assets/cours.json');

  return compute(parseCours, response.body);
}*/

List<Cours> parseCours(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Cours>((json) => Cours.fromJson(json)).toList();
}
 Administrateur admins;
class GestionEnseignant extends StatefulWidget {
  final Administrateur admin;
  GestionEnseignant({@required this.admin});
  @override 
  State<StatefulWidget> createState() {
    admins=admin;
    return _GestionEnseignantState();
  }
}

class _GestionEnseignantState extends State<GestionEnseignant> {
  String _titre;
  String _competence;
  String _durree;
  String _file;
  var _searchview = new TextEditingController();

  String filterType = "today";
  DateTime today = new DateTime.now();
  String taskPop = "close";

  @override
  Widget build(BuildContext context) {
    print("iiiiii index courant --------------------------");
    print(_currentIndex);
    if (_currentIndex == 0) {
      maValue = "enseignants";
    }
    if (_currentIndex == 1) {
      maValue = "ajouter";
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SideDrawerAdmin(admin:admins),
      appBar: AppBar(
        title: Text(admins.nom.toUpperCase() + ' '+admins.prenom),
        backgroundColor: Color(0x96066fff),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.person_pin),
            title: new Text('Enseignants'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person_add_alt_1_sharp),
            title: (Text('nouveau')),
          ),
        ],
      ),
      body: (() {
        String value = maValue;
        print("_____________________ TEST ______");
        print(value);
        if (value == "enseignants")
          return Container(
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
                        "Admin > Gestion Enseignants",
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
                        hintText: " Search Enseignant",
                        hintStyle: new TextStyle(color: Colors.grey[200]),
                      ),
                      autofocus: false,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 99, 0, 0),
                  child: (() {
                    if (ListeCours == null) {
                      return FutureBuilder<List>(
                          future: fetchCours(),
                          builder: (context, AsyncSnapshot<List> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator());
                              default:
                                if (snapshot.hasError) {
                                  print("Errorrrr");
                                  return Text('Error');
                                } else {
                                  ListeCours = snapshot.data;
                                  _id = ListeCours.length;
                                  return CoursList(
                                    cours: snapshot.data,
                                  );
                                }
                            }
                          });
                    } else
                      return CoursList(
                        cours: ListeCours,
                      );
                  }()))
            ],
          ));

        if (value == "ajouter")
          return Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.admin_panel_settings),
                    label: Text(
                      "Admin > Creer Compte Enseignant",
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    child: Form(
                      child: Padding(
                        padding: new EdgeInsets.all(10),
                        child: new Column(
                          children: <Widget>[
                            new TextFormField(
                              // controller: emailController,
                              keyboardType: TextInputType.text,
                              initialValue: titreInit,
                              autofocus: true,
                              decoration: new InputDecoration(
                                  hintText: 'lecon 1', labelText: 'Titre'),
                              onChanged: (text) {
                                setState(() {
                                  _titre = text;
                                });
                              },
                            ),
                            new TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: competenceInit,
                              decoration: new InputDecoration(
                                  hintText: 'entre la competence',
                                  labelText: 'Competence'),
                              onChanged: (text) {
                                setState(() {
                                  _competence = text;
                                });
                              },
                            ),
                            new TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: heureInit.toString(),
                              decoration: new InputDecoration(
                                  hintText: '1', labelText: 'Nombre d\'heure'),
                              onChanged: (text) {
                                setState(() {
                                  _durree = text;
                                });
                              },
                            ),
                            new Align(
                              alignment: Alignment.centerLeft,
                              child: DropdownButton(
                                  value: _value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Français"),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Anglais"),
                                      value: 2,
                                    ),
                                  ],
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      _value = value;
                                    });
                                  }),
                            ),
                            new TextFormField(
                              // controller: emailController,
                              keyboardType: TextInputType.text,
                              initialValue: "Test",
                              decoration: new InputDecoration(
                                  hintText: 'entre la competence',
                                  labelText: 'fichier du cour'),
                            ),
                            TextField(
                              onChanged: (text) {
                                print("First text field: $text");
                              },
                            ),
                            (() {
                              if (edit == 0) {
                                return Container(
                                  child: new RaisedButton(
                                    color: Colors.blue,
                                    onPressed: ajoutCour,
                                    child: Text(
                                      'Ajouter',
                                    ),
                                  ),
                                  margin: new EdgeInsets.only(top: 20.0),
                                );
                              } else
                                return Container(
                                  child: new RaisedButton(
                                    color: Colors.orange,
                                    onPressed: editCour,
                                    child: Text(
                                      'Editer',
                                    ),
                                  ),
                                  margin: new EdgeInsets.only(top: 20.0),
                                );
                            }()),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
      }()),
    );
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

  ajoutCour() {
    String _type;
    if (_value == 1) {
      _type = "Français";
    } else if (_value == 2) {
      _type = "Anglais";
    }
    _id++;
    Cours newcour = Cours(
        id: _id,
        titre: _titre,
        durree: int.parse(_durree),
        competence: _competence,
        type: _type,
        file: "fichier");

    print("test ajout Liste");
    print(ListeCours.length);

    ListeCours.add(newcour);
    print("Appres Liste");
    print(ListeCours.length);

    print(_titre);
    print(_competence);
    print(_durree);
    print(_value);
    setState(() {
      _currentIndex = 0;
    });
  }

  editCour() {
    String _type;
    if (_value == 1) {
      _type = "Français";
    } else if (_value == 2) {
      _type = "Anglais";
    }
    Cours newcour = Cours(
        id: ide,
        titre: _titre,
        durree: int.parse(_durree),
        competence: _competence,
        type: _type,
        file: "fichier");
    int j = 0;
    for (var i = 0; i < ListeCours.length; i++) {
      if (ListeCours[i].id == ide) {
        ListeCours.remove(ListeCours[i]);
        ListeCours.insert(j, newcour);
      }
      j++;
    }

    setState(() {
      _currentIndex = 0;
      initialState();
    });
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.cours.length,
        itemBuilder: (context, int index) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                taskWidget(widget.cours[index]),
              ],
            ),
          );
        });
  }

  Slidable taskWidget(Cours cours) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      closeOnScroll: true,
      child: Container(
        height: 70,
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
            Container(
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
      actions: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: IconSlideAction(
            caption: cours.id.toString(),
            //color: Colors.blue,
            foregroundColor: Colors.blue,
            icon: Icons.remove_red_eye,

            //onTap: () => _showSnackBar('Archive'),
          ),
        )
      ],
      secondaryActions: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: IconSlideAction(
            caption: "Edit",
            foregroundColor: Colors.blue[500],
            icon: Icons.edit,
            onTap: () {
              // OnEdit(cours);
              print("---- Edit Value---------");
              int val;
              if (cours.type == "Français") {
                val = 1;
              }
              if (cours.type == "Anglais") {
                val = 2;
              }
              setState(() {
                edit = 1;
                ide = cours.id;
                _currentIndex = 1;
                titreInit = cours.titre;
                competenceInit = cours.competence;
                heureInit = cours.durree;
                _value = val;
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GestionEnseignant()));
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: IconSlideAction(
            caption: "Delete",
            //color: Colors.red[400],
            icon: Icons.delete,
            onTap: () {
              Ondelete(cours);
            },
            foregroundColor: Colors.red[500],
          ),
        ),
      ],
    );
  }

  void Ondelete(Cours cours) {
    animated_dialog_box.showRotatedAlert(
        title: Center(
            child: Text(
          "INFO",
          style: TextStyle(color: Colors.blue[700]),
        )),
        context: context,
        firstButton: MaterialButton(
          // FIRST BUTTON IS REQUIRED
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.red,
          child: Text('Supprimer'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
            ListeCours.remove(cours);
            setState(() {
              ListeCours = ListeCours;
            });
          },
        ),
        secondButton: MaterialButton(
          // OPTIONAL BUTTON
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.blue,
          child: Text('Annuler'),
          onPressed: () =>
              {Navigator.of(context, rootNavigator: true).pop('dialog')},
        ),
        icon: Icon(
          Icons.info_outline,
          color: Colors.red,
        ), // IF YOU WANT TO ADD ICON
        yourWidget: Center(
          child: Text('Voulez vous supprimer cette lecon ?'),
        ));
  }

  OnEdit(Cours cours) {
    print("---- Edit Value---------");
    int val;
    if (cours.type == "Français") {
      val = 1;
    }
    if (cours.type == "Anglais") {
      val = 2;
    }
    setState(() {
      _currentIndex = 1;
      titreInit = cours.titre;
      competenceInit = cours.competence;
      heureInit = cours.durree;
      _value = val;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GestionEnseignant()));
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Side menu  FlutterCorner',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
