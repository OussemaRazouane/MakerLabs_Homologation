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
        title:Text(type,style:const TextStyle(fontSize: titleSize,color:textColor),),
        centerTitle: true,
        backgroundColor: bgColorApp,
      ),
      backgroundColor: bgColorGen,
      body:NumberScreen(
        name1:"Power board" , 
        name2: "Command board",
        name3: "Mechanical design", 
        name4: "Electrical design",
        name5:type=="All roads"?"Remote Control design":null,
        maxName3:20,
        maxName4:20,
        routeForward:SecondScreen.routeName,
      ),
    );
  }
}