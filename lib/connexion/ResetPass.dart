import 'package:flutter/material.dart';
import 'package:sabilapp/connexion/ForgetPass.dart';
import 'package:sabilapp/connexion/PassWordChange.dart';

String Roles="toto";

class ResetPassword extends StatelessWidget {
  final String role;
  ResetPassword({@required this.role});
  @override
  Widget build(BuildContext context) {
  Roles=role;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: resetPassword(),
    );
  }
}

class resetPassword extends StatefulWidget {
  @override
  _resetPasswordState createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
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
              height: 10,
            ),
            Text(
              "Reinitialiser vote mot de passe",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              "Consulter votre mail et renseigner le code recu pour reinitailiser votre mot de passe",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Entrer le code",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            TextField(
              decoration: InputDecoration(hintText: "****"),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Password",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            TextField(
              decoration:
                  InputDecoration(hintText: "Entre le nouveau mot de passe"),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Confirm Password",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            TextField(
              decoration:
                  InputDecoration(hintText: "Confirmer votre mot de passe"),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: openSuccessPage,
                child: Container(
                  width: MediaQuery.of(context).size.width - 10,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xfff96060)),
                  child: Center(
                    child: Text(
                      "Change Password",
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

  void openSuccessPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PasswordChangedSuccessfully(role:Roles)));
  }

  openBack() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPassword(role:Roles)));
  }
}
