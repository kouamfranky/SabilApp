import 'package:flutter/material.dart'; 
class DetailCour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'avenir'
      ),
      home: detailCour(),
    );
  }
}
class detailCour extends StatefulWidget {
  @override
  _detailCourState createState() => _detailCourState();
}

class _detailCourState extends State<detailCour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
                backgroundColor: Color(0x96066fff),
                elevation: 0,
                leading: IconButton(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                title: Text(
                  "Kouam Franky Brice",
                  style: TextStyle(fontSize: 25),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.short_text,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("asset/image/success.png")
              )
            ),
          ),
          Text("Successful!", style: TextStyle(
            fontSize: 35
          ),),
          Text("You have successfully changed our password. Please use your new password to login!", style: TextStyle(
            fontSize: 18,
          ),textAlign: TextAlign.center,),
          SizedBox(height: 70,),
          Center(
            child: InkWell(
              onTap: openHomePage,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Color(0xfff96060)
                ),
                child: Text("Continue", style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void openHomePage()
  {
  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }
}

