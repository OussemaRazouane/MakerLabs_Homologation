import 'package:flutter/material.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/basic/second_screen.dart';
import 'package:makerlab/widgets/number.dart';


class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});
  static String routeName = "FirstScreen";
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String type=CacheHelper.getData(key: "Type");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(type,style:const TextStyle(fontSize: titleSize),),
        centerTitle: true,
      ),
      body:NumberScreen(
        name1:"Carte de puissance" , 
        name2: "Carte de commande", 
        name3: "Conception mecanique", 
        name4: "Conception electrique",
        routeForward:SecondScreen.routeName,
      ),
    );
  }
}