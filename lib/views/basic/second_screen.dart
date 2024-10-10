import 'package:flutter/material.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/data_sheet.dart';
import 'package:makerlab/widgets/number.dart';


class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});
  static String routeName = "SecondScreen";
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String type=CacheHelper.getData(key: "Type");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(type,style:const TextStyle(fontSize: titleSize,color:textColor),),
        centerTitle: true,
        backgroundColor: bgColorApp,
      ),
      backgroundColor: bgColorGen,
      body:NumberScreen(
        name1:"Poids" , 
        name2: "Langeur", 
        name3: "Largeur", 
        name4: "Hauteur",
        routeForward: Data.routeName,
      ),
    );
  }
}