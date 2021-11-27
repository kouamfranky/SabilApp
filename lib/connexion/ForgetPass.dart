import 'package:flutter/material.dart';
import 'package:sabilapp/connexion/Login.dart';
import 'package:sabilapp/connexion/ResetPass.dart';

String Roles="toto";

class ForgotPassword extends StatelessWidget {
  final String role;
  ForgotPassword({@required this.role});
  @override
  Widget build(BuildContext context) {
  Roles=role;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'avenir',
      ),
      home: forgotPassword(),
    );
  }
}

class forgotPassword extends StatefulWidget {
  @override
  _forgotPasswordState createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: openBack,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Mot de Passe Oublié",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              "veillez entrer votre adresse mail pour reinitialiser votre mot de passe",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Mail ID",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            TextField(
              decoration: InputDecoration(hintText: "julio@gmai.com"),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 40),
            Center(
              child: InkWell(
                onTap: openResetPassword,
                child: Container(
                  width: MediaQuery.of(context).size.width - 10,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Color(0x96066fff)),
                  child: Center(
                    child: Text(
                      "Envoyer",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void openResetPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResetPassword(role:Roles)));
  }

  openBack() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage(role:Roles)));
  }
}
