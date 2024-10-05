import 'package:flutter/material.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/data_sheet.dart';
import 'package:makerlab/widgets/number.dart';


class FighterS3 extends StatefulWidget {
  const FighterS3({super.key});
  static String routeName = "FighterS3";
  @override
  State<FighterS3> createState() => _FighterS3State();
}

class _FighterS3State extends State<FighterS3> {
  String type=CacheHelper.getData(key: "Type");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(type,style:const TextStyle(fontSize: titleSize),),
        centerTitle: true,
      ),
      body:NumberScreen(
        name1:"Control board created by the team",
        name2:"Remote control board created by the team",
        name3:"Emergency button accessible",
        routeForward: Data.routeName,
      ),
    );
  }
}