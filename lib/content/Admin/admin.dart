import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sabilapp/api/Other/Administrateur.dart';
import 'package:sabilapp/content/Admin/theme/constants.dart';
import 'package:sabilapp/content/Admin/theme/dashboard/components/file_info_card.dart';
import 'package:sabilapp/content/Admin/theme/dashboard/components/my_fiels.dart';
import 'package:sabilapp/content/Admin/theme/dashboard/models/MyFiles.dart';
import 'package:sabilapp/content/Admin/theme/responsive.dart';
import 'package:sabilapp/content/menu.dart';

 Administrateur admins;

class AdminHome extends StatelessWidget {
  final Administrateur admin;
  AdminHome({@required this.admin});
  @override
  Widget build(BuildContext context) {
    admins=admin;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SideDrawerAdmin(admin: admins,),
      appBar: AppBar(
        title: Text(admins.nom.toUpperCase() + ' '+admins.prenom),
        backgroundColor: Color(0x96066fff),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.admin_panel_settings),
                  label: Text("Administration"),
                ),
              ],
            ),
            SizedBox(height: defaultPadding),
            Responsive(
              mobile: FileInfoCardGridView(
                crossAxisCount: _size.width < 650 ? 2 : 3,
                childAspectRatio: _size.width < 650 ? 1.1 : 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(random.nextInt(300), random.nextInt(300),
        random.nextInt(300), random.nextInt(300));
  }
}


class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiels.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: demoMyFiels[index],admins: admins,),
    );
  }
}
