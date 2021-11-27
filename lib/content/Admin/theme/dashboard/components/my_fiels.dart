import 'package:flutter/material.dart'; 
import 'package:sabilapp/content/Admin/theme/constants.dart';
import 'package:sabilapp/content/Admin/theme/dashboard/models/MyFiles.dart';
import 'package:sabilapp/content/Admin/theme/responsive.dart'; 
import 'file_info_card.dart';

class MyFiels extends StatelessWidget {
  const MyFiels({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
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
    );
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
      itemBuilder: (context, index) => FileInfoCard(info: demoMyFiels[index]),
    );
  }
}
