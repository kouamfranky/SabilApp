import 'dart:async';
import 'dart:convert';

import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sabilapp/api/Classes/Classes.dart';
import 'package:sabilapp/api/Eleves/Eleves.dart';
import 'package:sabilapp/api/Other/Administrateur.dart';
import 'package:sabilapp/api/constapi.dart';
import 'package:sabilapp/content/cours.dart';
import 'package:sabilapp/content/menu.dart';

String maValue;
List<Eleves> ListeCours = null;
List<Eleves> ListeElevesFilter = null;
List<Classes> ListeClasses = null;
List<Classes> ListeClassesNiveau = null;
List<Eleves> ListeEleves = null;

int isGetEleves = 1;
int _currentIndex = 0;
int _valNiveau = 1;
int statusDel = -1;
String _valClasse = "";
int ide;
int edit = 0;
String titreInit = "";
String competenceInit = "";
int heureInit = 1;
String nomInit = "";
String prenomInit = "";
String usernameInit = "";
String passwordInit = "";
initialState() {
  edit = 0;
  nomInit = "";
  prenomInit = "";
  usernameInit = "";
  passwordInit = "";
}

/*
Future<List<Eleves>> fetchCours(http.Client client) async {
  print("--------------- fffffffffffffffffdddddddddd -------------");
  final response = await client.get('assets/cours.json');

  return compute(parseCours, response.body);
}*/

List<Classes> parseClasse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Classes>((json) => Classes.fromJson(json)).toList();
}

List<Eleves> parseEleves(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Eleves>((json) => Eleves.fromJson(json)).toList();
}

Administrateur admins;

class GestionEleves extends StatefulWidget {
  final Administrateur admin;
  GestionEleves({@required this.admin});
  @override
  State<StatefulWidget> createState() {
    admins = admin;
    return _GestionEleveState();
  }
}

class _GestionEleveState extends State<GestionEleves> {
  String _nom;
  String _prenom;
  String _username;
  String _password;
  String _competence;
  String _durree;
  String _file;
  var _searchview = new TextEditingController();

  String filterType = "today";
  DateTime today = new DateTime.now();
  String taskPop = "close";
  final _formKey = GlobalKey<FormState>();
  List<Classes> getListClasses;
  List<String> tabClasse = [];
  List<Eleves> getListeEleves;
  Future<List<Classes>> getClasseNiveau(
      http.Client client, String niveau) async {
    print("------------ENTRE GET NIVEAU ___________----");
    final response = await client.get(
      Uri.parse(baseUrl + 'classes/niveau/' + niveau),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("--------------------RESPONSE GET NIVEAU -------------------");
    print(response.statusCode);
    print(response.body.toString());
    List<String> tabClasse1 = [];
    getListClasses = parseClasse(response.body);
    print(getListClasses.length);

    for (var i = 0; i < getListClasses.length; i++) {
      print("----------------- In Niveu classes -------------");
      tabClasse1.add(getListClasses[i].nomClasse.toString());
    }
    print(tabClasse1.length);
    print(tabClasse1[0]);

    setState(() {
      ListeClassesNiveau = parseClasse(response.body);
      tabClasse = tabClasse1;
      _valClasse = tabClasse[0];
    });
    print(tabClasse.toString());
    print(tabClasse.length);
    print("-------------------- SORIE Get NIVEAU -------------------");
  }

  @override
  Future<List<Eleves>> getEleves(http.Client client) async {
    final response = await client.get(
      Uri.parse(baseUrl + 'eleves'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("--------------------RESPONSE GEST ELEVES -------------------");

    print(response.statusCode);

    print(response.body.toString());
    print("--------------------RESPONSE GEST SORIE -------------------");

    getListeEleves = parseEleves(response.body);

    print(getListeEleves[0].classe.toString());
    print(getListeEleves[0].classe.nomClasse.toString());
    setState(() {
      ListeEleves = getListeEleves;

      ListeElevesFilter = getListeEleves;
    });
    print("--------------------RESPONSE GEST SORIE -------------------");
  }

  Future<Response> CreateEleves(Eleves eleve) async {
     print("------------------ ENTER -------------------");
    //print(cour.toJson()); 
    var response;
    try {
      response = await Dio()
          .post(baseUrl+'eleves/add', data: {
        "nom": eleve.nom,
        "prenom": eleve.prenom,
        "username": eleve.username,
        "password": eleve.password,
        "classe": eleve.classe.toJson(),
      });

      getEleves(http.Client());
      setState(() {
        _currentIndex = 0;
      });
    } catch (e) {
      print(" Erreur test post");
      print(e);
    }
    return response;
  }
  @override
  Widget build(BuildContext context) {
    print("iiiiii index courant --------------------------");
    print(_currentIndex);
    if (_currentIndex == 0) {
      maValue = "eleves";
    }
    if (_currentIndex == 1) {
      maValue = "ajouter";
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: SideDrawerAdmin(
        admin: admins,
      ),
      appBar: AppBar(
        title: Text(admins.nom.toUpperCase() + ' ' + admins.prenom),
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
            title: new Text('Eleves'),
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
        if (value == "eleves")
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
                        "Admin > Gestion Eleves",
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
                        hintText: " Search eleve",
                        hintStyle: new TextStyle(color: Colors.grey[200]),
                      ),
                      autofocus: false,
                      textAlign: TextAlign.left,
                       onChanged: (text) {
                        print("Value: $text");
                        setState(() {
                          ListeEleves = ListeElevesFilter.where((element) =>
                              (element.nom
                                  .toLowerCase()
                                  .contains(text.toLowerCase())||element.prenom
                                  .toLowerCase()
                                  .contains(text.toLowerCase()))).toList();
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
                    switch (ListeEleves) {
                      case null:
                        getEleves(http.Client());
                        getClasseNiveau(http.Client(), 'sixeme');
                        // if(isGetEleves==1){isGetEleves=0;getEleves(http.Client());getClasseNiveau(http.Client(),'sixeme');}
                        return Center(child: CircularProgressIndicator());
                      default:
                        return ElevesList(
                          eleves: ListeEleves,
                        );
                    }
                  }()))
            ],
          ));

        if (value == "ajouter")
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.admin_panel_settings),
                    label: Text(
                      "Admin > Creer Compte eleve",
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: new EdgeInsets.all(10),
                        child: new Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: new TextFormField(
                                // controller: emailController,
                                keyboardType: TextInputType.text,
                                // initialValue: nomInit,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == ' ') {
                                    return 'ce champ est obligation';
                                  }
                                  return null;
                                },
                                autofocus: true,
                                decoration: new InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'entrer le nom',
                                    labelText: 'Nom'),
                                onChanged: (text) {
                                  setState(() {
                                    _nom = text;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: new TextFormField(
                                // controller: emailController,
                                keyboardType: TextInputType.text,
                                // initialValue: prenomInit,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == ' ') {
                                    return 'ce champ est obligation';
                                  }
                                  return null;
                                },
                                autofocus: true,
                                decoration: new InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'entrer le prenom',
                                    labelText: 'Prenom'),
                                onChanged: (text) {
                                  setState(() {
                                    _prenom = text;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: new Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text("Niveau : "),
                                      DropdownButton(
                                          value: _valNiveau,
                                          items: [
                                            DropdownMenuItem(
                                              child: Text("sixeme"),
                                              value: 1,
                                            ),
                                            DropdownMenuItem(
                                              child: Text("cinquime"),
                                              value: 2,
                                            ),
                                            DropdownMenuItem(
                                              child: Text("quatrieme"),
                                              value: 3,
                                            ),
                                          ],
                                          onChanged: (value) {
                                            String niveau = 'sixeme';
                                            if (value == 1) {
                                              niveau = 'sixeme';
                                            }
                                            if (value == 2) {
                                              niveau = 'cinquime';
                                            }
                                            if (value == 3) {
                                              niveau = 'quatrieme';
                                            }
                                            getClasseNiveau(
                                                http.Client(), niveau);
                                            print(value);
                                            setState(() {
                                              _valNiveau = value;
                                            });
                                          }),
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: new Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text("Classes : "),
                                      DropdownButton<String>(
                                          value: _valClasse,
                                          items: tabClasse
                                              .map<DropdownMenuItem<String>>(
                                                  (String e) {
                                            print(tabClasse.toString());
                                            print(e);
                                            return DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            print(value);
                                            setState(() {
                                              _valClasse = value;
                                            });
                                          }),
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: new TextFormField(
                                // controller: emailController,
                                keyboardType: TextInputType.text,
                                // initialValue: nomInit,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == ' ') {
                                    return 'ce champ est obligation';
                                  }
                                  return null;
                                },
                                autofocus: true,
                                decoration: new InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "entrer le nom d'utilisqteur",
                                    labelText: 'username'),
                                onChanged: (text) {
                                  setState(() {
                                    _username = text;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: new TextFormField(
                                // controller: emailController,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                // initialValue: prenomInit,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == ' ') {
                                    return 'ce champ est obligation';
                                  }
                                  return null;
                                },
                                autofocus: true,
                                decoration: new InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'entrer le mot de passe',
                                    labelText: 'Password'),
                                onChanged: (text) {
                                  setState(() {
                                    _password = text;
                                  });
                                },
                              ),
                            ),
                            (() {
                              if (edit == 0) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          textStyle:
                                              const TextStyle(fontSize: 20),
                                          primary: Colors.blue,
                                          padding: EdgeInsets.all(12)),
                                      onPressed: () {
                                        //CircularProgressIndicator();
                                        print(
                                            "---------------------- ENNNNNTRE -----------------------");
                                        print(_formKey.currentState.validate());
                                        // Validate returns true if the form is valid, or false otherwise.
                                        if (_formKey.currentState.validate()) {
                                          String _niveau = 'sixeme';
                                          if (value == 1) {
                                            _niveau = 'sixeme';
                                          }
                                          if (value == 2) {
                                            _niveau = 'cinquime';
                                          }
                                          if (value == 3) {
                                            _niveau = 'quatrieme';
                                          }
                                          Classes cl;
                                          for (var i = 0;
                                              i < ListeClassesNiveau.length;
                                              i++) {
                                            if (_valClasse ==
                                                ListeClassesNiveau[i]
                                                    .nomClasse) {
                                              cl = ListeClassesNiveau[i];
                                            }
                                          }
                                          print(
                                              "Voici la classe ${cl.id}, ${cl.niveau}, ${cl.nomClasse} ");
                                          print(_nom);
                                          print(_prenom);
                                          print(_niveau);
                                          print(_username);
                                          print(_password);
                                          Eleves newEleves = Eleves(
                                              nom: _nom,
                                              prenom: _prenom,
                                              niveau: _niveau,
                                              username: _username,
                                              password: _password,
                                              classe: cl);
                                          print(
                                              "-----------entre create eleves DATA --------");
                                          setState(() {});
                                          CreateEleves(newEleves);
                                          
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text('Processing Data')));
                                        }
                                      },
                                      child: Text(
                                        'Ajouter',
                                      ),
                                    ),
                                  ),
                                  margin: new EdgeInsets.only(top: 20.0),
                                );
                              } else
                                return Container(
                                  child: new RaisedButton(
                                    color: Colors.orange,
                                    onPressed: () async {
                                      String _niveau = 'sixeme';
                                      if (value == 1) {
                                        _niveau = 'sixeme';
                                      }
                                      if (value == 2) {
                                        _niveau = 'cinquime';
                                      }
                                      if (value == 3) {
                                        _niveau = 'quatrieme';
                                      }
                                      Eleves neweleves = Eleves(
                                          id: ide,
                                          nom: _nom,
                                          prenom: _prenom,
                                          niveau: _niveau,
                                          username: _username,
                                          password: _password);
                                      // updateCour(newcour);
                                    },
                                    child: Text(
                                      'Editer',
                                      style: TextStyle(fontSize: 20),
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
}

class ElevesList extends StatefulWidget {
  final List<Eleves> eleves;
  ElevesList({Key key, this.eleves}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ElevesList();
  }
}

class _ElevesList extends State<ElevesList> {
  List<Eleves> getListCours;
  Future<List<Eleves>> getElevess(http.Client client) async {
    final response = await client.get(
      Uri.parse(baseUrl + 'eleves'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      ListeEleves = parseEleves(response.body);
      ListeElevesFilter = parseEleves(response.body);
    });
    print("--------------------RESPONSE GEST SORIE -------------------");
  }

  Future<http.Response> deleteEleves(String id) async {
    final http.Response response = await http.delete(
      Uri.parse(baseUrl + 'eleves/delete/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("--------------------- DELETE -----------------------");
    print(response.statusCode);
    statusDel = response.statusCode;

    // getCourss(http.Client());

    return response;
  }

  @override
  Widget build(BuildContext context) {
    Slidable taskWidget(Eleves eleve) {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.17,
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
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                padding: EdgeInsets.all(5),
                //height: 45,
                //width: 45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blueGrey, width: 2)),
                child: Icon(
                  Icons.person_rounded,
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
                        eleve.nom + " " + eleve.prenom,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            eleve.classe.nomClasse.toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                                fontSize: 16
                                //backgroundColor: Colors.red
                                ),
                          ),
                          Text(
                            eleve.classe.niveau,
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
              caption: eleve.id.toString(),
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
                /*/ OnEdit(cours);
                print("---- Edit Value---------");
                int val;
                if (eleve.type == "Français") {
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
                    MaterialPageRoute(builder: (context) => GestionCours()));
              */
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
                      onPressed: () async {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                        await deleteEleves(eleve.id.toString());
                          print("satuus sup : $statusDel");
                        if (statusDel == 200) {
                          ListeEleves.remove(eleve);
                         // ListeElevesFilter.remove(eleve);
                          getElevess(http.Client());
                        }
                      },
                    ),
                    secondButton: MaterialButton(
                      // OPTIONAL BUTTON
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.blue,
                      child: Text('Annuler'),
                      onPressed: () => {
                        Navigator.of(context, rootNavigator: true).pop('dialog')
                      },
                    ),
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.red,
                    ), // IF YOU WANT TO ADD ICON
                    yourWidget: Center(
                      child: Text('Voulez vous supprimer cette lecon ?'),
                    ));
              },
              foregroundColor: Colors.red[500],
            ),
          ),
        ],
      );
    }

    return ListView.builder(
        itemCount: widget.eleves.length,
        itemBuilder: (context, int index) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                taskWidget(widget.eleves[index]),
              ],
            ),
          );
        });
  }
}
