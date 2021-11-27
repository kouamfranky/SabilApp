import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sabilapp/api/Eleves/Eleves.dart';
import 'package:sabilapp/api/Other/Administrateur.dart';
import 'package:http/http.dart' as http;
import 'package:sabilapp/api/constapi.dart';
import 'package:sabilapp/content/Admin/admin.dart';
import 'package:sabilapp/content/Eleves/eleves.dart';
import 'package:sabilapp/content/Enseignant/enseignant.dart';
import 'package:sabilapp/home.dart';
import 'ForgetPass.dart';
import 'package:flutter/foundation.dart';

String Roles = "toto";
String username = "";
String password = "";
int testlogin = -1;
List<Administrateur> ListeAdmin = null;
List<Eleves> ListeEleves = null;

initialState() {
  username = "";
  password = "";
  testlogin = -1;
}

List<Administrateur> parseAdmin(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<Administrateur>((json) => Administrateur.fromJson(json))
      .toList();
}

class LoginPage extends StatelessWidget {
  final String role;
  LoginPage({@required this.role});
  @override
  Widget build(BuildContext context) {
    print("----------8888888----");
    print("----------9999999----");
    print(role);
    initialState();
    Roles = role;
    print(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: loginPage(),
    );
  }
}

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  List<Administrateur> getListAdmin;
  List<Eleves> getListEleves;
  final _formKey = GlobalKey<FormState>();

  Future<List<Administrateur>> getAdmin(http.Client client) async {
    print("ENTRE GET ADMIN -------------------");
    final response = await client.get(
      Uri.parse(baseUrl + 'admin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    print(response.body[0]);
    getListAdmin = parseAdmin(response.body);
    print(getListAdmin[0].username);
    setState(() {
      ListeAdmin = getListAdmin;
    });
    print("SORTI GET ADMIN -------------------");
  }

  List<Eleves> parseEleves(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Eleves>((json) => Eleves.fromJson(json)).toList();
  }

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

    getListEleves = parseEleves(response.body);

    print(getListEleves[0].classe.toString());
    print(getListEleves[0].classe.nomClasse.toString());
    setState(() {
      ListeEleves = getListEleves;
    });
    print("--------------------RESPONSE GEST SORIE -------------------");
  }

  @override
  Widget build(BuildContext context) {
    print(Roles);
    return WillPopScope(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Color(0x96066fff),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: openOnBoard,
                ),
                title: Text(
                  "Sabil App",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                )),
            body: Stack(children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Connexion " + Roles,
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Julio",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value == ' ') {
                            return 'ce champ est obligation';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 15),
                        onChanged: (text) {
                          print(text);
                          setState(() {
                            username = text;
                          });
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                              hintText: "Entrer votre mot de passe"),
                          style: TextStyle(fontSize: 15),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == ' ') {
                              return 'ce champ est obligation';
                            }
                            return null;
                          },
                          obscureText: true,
                          onChanged: (text) {
                            print(text);
                            setState(() {
                              password = text;
                            });
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: openForgotPassword,
                            child: Text(
                              "mot de passe oublier ?",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: InkWell(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                openUser();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Data')));
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 10,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      color: Color(0x96066fff)),
                                  child: Center(
                                    child: Text(
                                      "Connexion",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: (() {
                                    if (testlogin == 0) {
                                      return Center(
                                          child: Text(
                                              "username ou mot de passe incorrect",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 18)));
                                    } else
                                      return Text("");
                                  }()),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ])),
        onWillPop: () => showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                title: Text('Warning'),
                content: Text('Voulez vous quitter ??'),
                actions: [
                  FlatButton(
                    child: Text('Oui'),
                    onPressed: () => Navigator.pop(c, true),
                  ),
                  FlatButton(
                    child: Text('Non'),
                    onPressed: () => Navigator.pop(c, false),
                  ),
                ],
              ),
            ));
  }

  void openOnBoard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Onboarding()));
  }

  void openDasbaord() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Onboarding()));
  }

  void openForgotPassword() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ForgotPassword(role: Roles)));
  }

  void openUser() async {
    print("________________User open _________");
    print(Roles);
    if (Roles == "Eleve") {
      print("avant eleve _________");
      await getEleves(http.Client());
      print("apres eleve_________");
      print("Taille eleve: ${ListeEleves.length}");
      for (var i = 0; i < ListeEleves.length; i++) {
        if (ListeEleves[i].username.toLowerCase() == username.toLowerCase() &&
            ListeEleves[i].password.toLowerCase() == password.toLowerCase()) {
            print("____________reussite _________");

          testlogin = 1;
          setState(() {
            testlogin = 1;
          });

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ElevesHome(eleve: ListeEleves[i])));
        }
      }
      setState(() {
        testlogin = 0;
      });
    }

    if (Roles == "Enseignant") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EnseignantHome()));
    }
    if (Roles == "Admin") {
      print("avant _________");
      await getAdmin(http.Client());
      print("apres _________");
      print("Taille: ${ListeAdmin.length}");
      for (var i = 0; i < ListeAdmin.length; i++) {
        if (ListeAdmin[i].username.toLowerCase() == username.toLowerCase() &&
            ListeAdmin[i].password.toLowerCase() == password.toLowerCase()) {
          testlogin = 1;
          setState(() {
            testlogin = 1;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminHome(admin: ListeAdmin[i])));
        }
      }
      setState(() {
        testlogin = 0;
      });
    }
  }
}
