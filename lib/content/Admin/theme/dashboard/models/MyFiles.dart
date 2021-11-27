 
import 'package:flutter/material.dart';
import 'package:sabilapp/content/Admin/theme/constants.dart';

class CloudStorageInfo {
  final String svgSrc, title, totalStorage,numOfFiels;
  final int percentage;
  final Color color;

  CloudStorageInfo(
      {this.svgSrc,
      this.title,
      this.totalStorage,
      this.numOfFiels,
      this.percentage,
      this.color});
}

List demoMyFiels = [
  CloudStorageInfo(
    title: "Gestion des enseignants",
    numOfFiels: "1328 Enseignants",
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "1.9GB",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Gestion des eleves",
    numOfFiels: "1328 eleves",
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Gestion des Cours",
    numOfFiels: "1328 Cours",
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Gestion des Salles",
    numOfFiels: "5328 Salles",
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
