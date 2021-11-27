import 'package:flutter/material.dart';
import 'connexion/Login.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: onboarding(),
    );
  }
}

class onboarding extends StatefulWidget {
  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  int currentPage = 0;
  PageController _pageController =
      new PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.58,
                child: PageView(
                  controller: _pageController,
                  children: [
                    onBoardPage("1", "Bienvenue chez nous!","Au collège Bilingue Sabil de Maroua"),
                    onBoardPage("2", "Nos Objectifs","Votre encadrement; droit à la reussite; votre sécurité"),
                    onBoardPage("3", "Vue d'ensemble","Le temple du Savoir"),
                    onBoardPage("4", "Direction du college"," Bienvenue chez ATIKOU BABA votre Principale, à votre service."),
                  ],
                  onPageChanged: (value) => {setCurrentPage(value)},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => getIndicator(index)),
              ),
              Expanded(
                child: Container(
                  height: 300, // MediaQuery.of(context).size.height ,
                  //   color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('asset/image/path2.png'),
                          fit: BoxFit.fill)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Connectez-vous en tant que?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: openLoginPageAdmin,
                        child: Container(
                          margin: EdgeInsets.only(top: 17),
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0, 9),
                                    blurRadius: 20,
                                    spreadRadius: 3)
                              ]),
                          child: Center(
                            child: Text(
                              "Administrateur",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: openLoginPageEnseignant,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0, 9),
                                    blurRadius: 20,
                                    spreadRadius: 3)
                              ]),
                          child: Center(
                            child: Text(
                              "Enseignant",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: openLoginPageEleve,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0, 9),
                                    blurRadius: 20,
                                    spreadRadius: 3)
                              ]),
                          child: Center(
                            child: Text(
                              "Elèves",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AnimatedContainer getIndicator(int pageNo) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: (currentPage == pageNo) ? Colors.black : Colors.grey),
    );
  }

  Column onBoardPage(String img, String title, String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('asset/image/$img.jpg'))),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  setCurrentPage(int value) {
    currentPage = value;
    setState(() {});
  }

  openLoginPageEleve() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginPage(role: 'Eleve')));
  }

  openLoginPageEnseignant() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginPage(role: 'Enseignant')));
  }

  openLoginPageAdmin() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginPage(role: 'Admin')));
  }
}
