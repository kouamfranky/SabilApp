import 'package:flutter/material.dart';
import 'package:sabilapp/api/Other/Administrateur.dart';
import 'package:sabilapp/content/Admin/GCours/Gestion_cours.dart';
import 'package:sabilapp/content/Admin/GEleves/Gestion_eleves.dart';
import 'package:sabilapp/content/Admin/GEnseignant/Gestion_enseignants.dart';
import 'package:sabilapp/content/Admin/GSalles/Gestion_salles.dart';
import 'package:sabilapp/home.dart';

Administrateur admins;

class SideDrawerAdmin extends StatelessWidget {
  final Administrateur admin;
  SideDrawerAdmin({@required this.admin});
  @override
  Widget build(BuildContext context) {
    admins = admin;
    print("Admin- MENU--------");
    print(admins.toString());
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            child: Center(
              child: Text(
                'Administrateur',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0x96066fff),
            ),
          ),
          ListTile(
            horizontalTitleGap: -7,
            tileColor: Colors.blue[100].withOpacity(0.2),
            leading: Icon(Icons.menu_rounded),
            title: Text('Gestion des utilisateurs'),
            onTap: () => {},
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            horizontalTitleGap: -7,
            leading: Icon(Icons.person_sharp),
            title: Text('Enseignants'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GestionEnseignant(admin: admins))),
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            horizontalTitleGap: -7,
            leading: Icon(Icons.person_sharp),
            title: Text('Eleves'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GestionEleves(admin: admins))),
            },
          ),
          ListTile(
            horizontalTitleGap: -7,
            tileColor: Colors.blue[100].withOpacity(0.2),
            leading: Icon(Icons.horizontal_split),
            title: Text('Gestion des Cours et Salles'),
            onTap: () => {},
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            horizontalTitleGap: -7,
            leading: Icon(Icons.menu_book_sharp),
            title: Text('Cours'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GestionCours(admin: admins))),
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            horizontalTitleGap: -7,
            leading: Icon(Icons.home_work_outlined),
            title: Text('Salles'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GestionSalles(admin: admins))),
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Onboarding())),
            },
          ),
        ],
      ),
    );
  }
}

class SideDrawerEnseignant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            child: Center(
              child: Text(
                'Kouam franky brice',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0x96066fff),
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            tileColor: Colors.blue[100].withOpacity(0.2),
            leading: Icon(Icons.menu_rounded),
            title: Text('Gestion des Cours'),
            onTap: () => {},
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            horizontalTitleGap: 0,
            leading: Icon(Icons.person_sharp),
            title: Text('Consulter'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            horizontalTitleGap: 0,
            leading: Icon(Icons.person_sharp),
            title: Text('Ajouter'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            horizontalTitleGap: 0,
            leading: Icon(Icons.send_outlined),
            title: Text('Envoyer un devoir'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            horizontalTitleGap: 0,
            leading: Icon(Icons.move_to_inbox),
            title: Text('Devoir reçu'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Onboarding())),
            },
          ),
        ],
      ),
    );
  }
}

class SideDrawerEleves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            child: Center(
              child: Text(
                'Kouam franky brice',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0x96066fff),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            horizontalTitleGap: 0,
            leading: Icon(Icons.menu_book_sharp),
            title: Text('Mes cours'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            horizontalTitleGap: 0,
            leading: Icon(Icons.move_to_inbox),
            title: Text('Mes devoirs'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            horizontalTitleGap: 0,
            leading: Icon(Icons.send_outlined),
            title: Text('Envoyer un devoir'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Onboarding())),
            },
          ),
        ],
      ),
    );
  }
}
