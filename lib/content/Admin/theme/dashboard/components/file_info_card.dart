import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sabilapp/api/Other/Administrateur.dart';
import 'package:sabilapp/content/Admin/GCours/Gestion_cours.dart';
import 'package:sabilapp/content/Admin/GEleves/Gestion_eleves.dart';
import 'package:sabilapp/content/Admin/GEnseignant/Gestion_enseignants.dart';
import 'package:sabilapp/content/Admin/GSalles/Gestion_salles.dart';
import 'package:sabilapp/content/Admin/theme/constants.dart';
import 'package:sabilapp/content/Admin/theme/dashboard/models/MyFiles.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key key,
    @required this.info,
    @required this.admins,
  }) : super(key: key);

  final CloudStorageInfo info;
  final Administrateur admins;

  @override
  Widget build(BuildContext context) {
    print(info);
    var lie;
    if (info.title == "Gestion des enseignants")
      lie = GestionEnseignant(admin: admins);
    if (info.title == "Gestion des eleves")
      lie = GestionEleves(admin: admins);
    if (info.title == "Gestion des Cours")
      lie = GestionCours(admin: admins);
    if (info.title == "Gestion des Salles")
      lie = GestionSalles(admin: admins);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => lie));
      },
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: info.color.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: info.color.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    info.svgSrc,
                    color: Colors.white70,
                  ),
                ),
                Icon(Icons.more_vert, color: Colors.white)
              ],
            ),
            Text(
              info.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            ProgressLine(
              color: info.color,
              percentage: info.percentage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  info.numOfFiels,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white70),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key key,
    this.color = primaryColor,
    @required this.percentage,
  }) : super(key: key);

  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
