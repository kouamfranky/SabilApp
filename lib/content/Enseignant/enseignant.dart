import 'dart:io';
import 'dart:async';
import 'dart:convert';

//import 'dart:html';

import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:diacritic/diacritic.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sabilapp/api/constapi.dart';
import 'package:sabilapp/content/menu.dart';
import '../cours.dart';

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

Future<List<Cours>> fetchCours(http.Client client) async {
  final response = await client.get(
    Uri.parse(baseUrl + '/cours'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return compute(parseCours, response.body);
}

List<Cours> parseCours(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Cours>((json) => Cours.fromJson(json)).toList();
}

class EnseignantHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EnseignantState();
  }
}

class _EnseignantState extends State<EnseignantHome> {
  File _file;
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  bool _hasValidMime = false;
  PlatformFile fileImport;
  bool _uplaodFile;
  String _downloadUrl;
  StorageReference _reference =
      FirebaseStorage.instance.ref().child("brice.pdf");

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  final client = Dio();
  List<Cours> getListCours;

  void _uploadFileddd(filePath) async {
    String fileName = basename(filePath.path);
    print("file base name : $fileName");

    try {
      FormData formData = new FormData.fromMap({
        "name": "brice",
        "age": 33,
        "file": await MultipartFile.fromFile(filePath.path, filename: fileName),
      });

      // Response response = await Dio().post(path)
    } catch (e) {}
  }

  Future<List<Cours>> getCours(http.Client client) async {
    final response = await client.get(
      Uri.parse(baseUrl + 'cours'),
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

  Future<Response> CreateCour(Cours cour) async {
    print("------------------ ENTER -------------------");
    //print(cour.toJson());
    var response;
    if (cour.titre != null) {
      try {
        response = await Dio().post(baseUrl + 'cours/add', data: {
          "competence": cour.competence,
          "durree": cour.durree,
          "file": cour.file,
          "titre": cour.titre,
          "type": cour.type,
        });

        getCours(http.Client());
      } catch (e) {
        print(" Erreur test post");
        print(e);
      }
    }
    return response;
  }

  Future getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
      setState(() {
        fileImport = file;
      });
      // print(fileImport.name);
    } else {
      // User canceled the picker
    }
  }

  Future uploadFile() async {
    _reference =
      FirebaseStorage.instance.ref().child(fileImport.name);
    final File fileForFirebase = File(fileImport.path);
    StorageUploadTask uploadTask = _reference.putFile(fileForFirebase);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      _uplaodFile = true;
    });
  }

  Future downloadFile() async{
    String downloadAddress = await _reference.getDownloadURL();
    setState(() {
      _downloadUrl =downloadAddress;
    });
  }

  Future<Response> updateCour(Cours cour) async {
    print("-------------- ENTRE UPDATE -----------------");
    var response;
    if (cour.titre != null) {
      try {
        response = await Dio().put(baseUrl + 'cours/update', data: {
          "id": cour.id,
          "competence": cour.competence,
          "durree": cour.durree,
          "file": cour.file,
          "titre": cour.titre,
          "type": cour.type,
        });
        print(response);
        getCours(http.Client());
      } catch (e) {
        print(" Erreur test Update");
        print(e);
      }
    }
    return response;
  }

  String _titre;
  String _competence;
  String _durree;
  var _searchview = new TextEditingController();

  String filterType = "today";
  DateTime today = new DateTime.now();
  String taskPop = "close";
  Cours _coursModel;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print("iiiiii index courant AVANT--------------------------");
    print("iiiiii index courant APRES--------------------------");
    print(_currentIndex);
    bool issloading = false;
    if (_currentIndex == 0) {
      maValue = "cours";
    }
    if (_currentIndex == 1) {
      maValue = "ajouter";
    }
    if (_currentIndex == 2) {
      maValue = "attacher";
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SideDrawerEnseignant(),
      appBar: AppBar(
        title: Text('Noms et Prenoms'),
        backgroundColor: Color(0x96066fff),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.file_present),
            title: new Text('Cours'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.add),
            title: (Text('Ajouter')),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.send_sharp), title: Text('attacher'))
        ],
      ),
      body: (() {
        String value = maValue;

        //print("_____________________ TEST ______");
        print(value);
        if (value == "cours")
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
                          ListeCours = ListeCoursFilter.where((element) =>
                              element.titre
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
                      "Enseignant > Creer un cour",
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
                                initialValue: titreInit,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == ' ') {
                                    return 'entre le titre de la lecon';
                                  }
                                  return null;
                                },
                                autofocus: true,
                                decoration: new InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'lecon 1',
                                    labelText: 'Titre'),
                                onChanged: (text) {
                                  setState(() {
                                    _titre = text;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: new TextFormField(
                                keyboardType: TextInputType.text,
                                initialValue: competenceInit,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == ' ') {
                                    return 'entre la competence';
                                  }
                                  return null;
                                },
                                decoration: new InputDecoration(
                                    hintText: 'entre la competence',
                                    border: UnderlineInputBorder(),
                                    labelText: 'Competence'),
                                onChanged: (text) {
                                  setState(() {
                                    _competence = text;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: new TextFormField(
                                keyboardType: TextInputType.number,
                                initialValue: heureInit.toString(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                decoration: new InputDecoration(
                                    hintText: '1',
                                    labelText: 'Nombre d\'heure'),
                                onChanged: (text) {
                                  print("ici la duree: $text");
                                  setState(() {
                                    _durree = text;
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
                                      Text(
                                        "Type :   ",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      DropdownButton(
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
                                    ],
                                  )),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        getFile();
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "File  :  ",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Icon(
                                            Icons.file_present,
                                            size: 28,
                                          ),
                                          (() {
                                            print(
                                                "----------------FILE----------------");
                                            print(fileImport);
                                            if (fileImport != null) {
                                              return Text(fileImport.name);
                                            } else
                                              return Container();
                                          }())
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            RaisedButton(
                                onPressed: () async {
                                  FilePickerResult result =
                                      await FilePicker.platform.pickFiles();

                                  if (result != null) {
                                    PlatformFile file = result.files.first;

                                    print(file.name);
                                    print(file.bytes);
                                    print(file.size);
                                    print(file.extension);
                                    print(file.path);
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                child: Text("file")),
                            Text("nnnnnnnnnn"),
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
                                      onPressed: () async{
                                        // Validate returns true if the form is valid, or false otherwise.
                                        if (_formKey.currentState.validate()) {
                                          // If the form is valid, display a snackbar. In the real world,
                                          // you'd often call a server or save the information in a database.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text('Processing Data')));
                                        } else {
                                          String _type;
                                          if (_value == 1) {
                                            _type = "Français";
                                          } else if (_value == 2) {
                                            _type = "Anglais";
                                          }
                                          print("Dure:$_durree");
                                          if (_durree == null) {
                                            _durree = '1';
                                          }
                                          Cours newcour = Cours(
                                              titre: _titre,
                                              durree: int.parse(_durree),
                                              competence: _competence,
                                              type: _type,
                                              file: "fichier");

                                          //await uploadFile();
                                          print(
                                              "-----------entre create cours DATA --------");
                                          setState(() {
                                            issloading == true;
                                          });
                                          CreateCour(newcour);
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
                                      String _type;
                                      if (_value == 1) {
                                        _type = "Français";
                                      } else if (_value == 2) {
                                        _type = "Anglais";
                                      }
                                      if (_durree == null) {
                                        _durree = '1';
                                      }
                                      Cours newcour = Cours(
                                          id: ide,
                                          titre: _titre,
                                          durree: int.parse(_durree),
                                          competence: _competence,
                                          type: _type,
                                          file: "fichier");
                                      updateCour(newcour);
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

        if (value == "attacher")
          return Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.admin_panel_settings),
                  label: Text(
                    "Enseignant > Envoyer un cours",
                  ),
                ),
              ),
            ],
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
    final response = await client.get(
      Uri.parse(baseUrl + 'cours'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    print(response.body[0]);

    getListCours = parseCours(response.body);
    print(getListCours[0].titre);
    setState(() {
      ListeCoursFilter = getListCours;
      ListeCours = getListCours;
    });
  }

  Future<http.Response> deleteCours(String id) async {
    final http.Response response = await http.delete(
      Uri.parse(baseUrl + 'cours/delete/$id'),
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
                        removeDiacritics(cours.titre),
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(
                        removeDiacritics(cours.competence),
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
                            removeDiacritics(cours.type),
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
                    MaterialPageRoute(builder: (context) => EnseignantHome()));
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
                        await deleteCours(cours.id.toString());
                        print("satuus sup : $statusDel");
                        if (statusDel == 200) {
                          ListeCours.remove(cours);
                          ListeCoursFilter.remove(cours);
                          getCourss(http.Client());
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
