import 'package:flutter/material.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/fighter/second_screen.dart';
import 'package:makerlab/widgets/number.dart';


class FighterS1 extends StatefulWidget {
  const FighterS1({super.key});
  static String routeName = "FighterS1";
  @override
  State<FighterS1> createState() => _FighterS1State();
}

class _FighterS1State extends State<FighterS1> {
  String type=CacheHelper.getData(key: "Type");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(type,style:const TextStyle(fontSize: titleSize),),
        centerTitle: true,
      ),
      body:NumberScreen(
        name1:"Mobile robot during certification",
        name2:"Active weapon during certification",
        name3:"Presence of electronic design",
        routeForward:FighterS2.routeName,
      ),
    );
  }
}