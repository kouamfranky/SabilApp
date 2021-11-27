import 'package:flutter/material.dart';
import 'package:sabilapp/Onboarding.dart'; 

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          onPressed: openOnBoard,
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
              "Connectez-Vous !",
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
            TextField(
              decoration: InputDecoration(hintText: "Julio"),
              style: TextStyle(fontSize: 15),
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
            TextField(
              obscureText: true,
              decoration:
                  InputDecoration(hintText: "Entrer votre mot de passe"),
              style: TextStyle(fontSize: 15),
            ),
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
            Container(
              width: MediaQuery.of(context).size.width - 10,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Color(0xfff96060)),
              child: Center(
                child: Text(
                  "Connexion",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
  //  Navigator.push(
    //    context, MaterialPageRoute(builder: (context) => ForgotPassword()));
  }
}
