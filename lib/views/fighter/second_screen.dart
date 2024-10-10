import 'package:flutter/material.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/fighter/third_screen.dart';
import 'package:makerlab/widgets/number.dart';


class FighterS2 extends StatefulWidget {
  const FighterS2({super.key});
  static String routeName = "FighterS2";
  @override
  State<FighterS2> createState() => _FighterS2State();
}

class _FighterS2State extends State<FighterS2> {
  String type=CacheHelper.getData(key: "Type");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          type,
          style: const TextStyle(fontSize: titleSize, color: textColor),
        ),
        centerTitle: true,
        backgroundColor: bgColorApp,
      ),
      backgroundColor: bgColorGen,
      body:NumberScreen(
        name1:"Presence of mechanical design",
        name2:"Robot Safety cectrical and mechanical",
        name3:"Power board created by the team",
        routeForward: FighterS3.routeName,
      ),
    );
  }
}