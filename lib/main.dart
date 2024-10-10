import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:makerlab/DataBase/cache_helper.dart';


import 'views/basic/first_screen.dart';
import 'views/basic/second_screen.dart';
import 'views/data_sheet.dart';
import 'views/fighter/first_screen.dart';
import 'views/fighter/second_screen.dart';
import 'views/fighter/Third_screen.dart';
import 'views/home.dart';
import 'views/name_screen.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    bool selectScreen=CacheHelper.containKey(key: "Type");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Maker",
      routes:{
        NameScreen.routeName:(context)=>const NameScreen(),
        Home.routeName:(context)=>const Home(),
        FirstScreen.routeName:(context)=>const FirstScreen(),
        SecondScreen.routeName:(context)=>const SecondScreen(),
        Data.routeName:(context)=>const Data(),
        FighterS1.routeName:(context)=>const FighterS1(),
        FighterS2.routeName:(context)=>const FighterS2(),
        FighterS3.routeName:(context)=>const  FighterS3(),
      },
      initialRoute:selectScreen?NameScreen.routeName:Home.routeName,
    );
  }
}