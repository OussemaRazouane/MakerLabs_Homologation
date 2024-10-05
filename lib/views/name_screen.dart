import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/basic/first_screen.dart';
import 'package:makerlab/views/data_sheet.dart';
import 'package:makerlab/views/fighter/first_screen.dart';
import 'package:makerlab/views/home.dart';
import 'package:makerlab/widgets/custom_fi.dart';


class NameScreen extends StatefulWidget {
  const NameScreen({super.key});
  static String routeName = "NameScreen";
  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  String type = CacheHelper.getData(key: "Type");
  GlobalKey<FormState> key1 = GlobalKey();
  GlobalKey<FormState> key2 = GlobalKey();

  List<Map<String, dynamic>> names = [
    {
      "name": "Robot name",
      "cont": TextEditingController(),
    },
    {
      "name": "Leader name",
      "cont": TextEditingController(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          type,
          style: const TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics:const BouncingScrollPhysics() ,
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < names.length; i++)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      names[i]["name"],
                      style: const TextStyle(fontSize: labelSize),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomField(
                      txtKey: i == 0 ? key1 : key2,
                      value: names[i]["cont"],
                      name: "Enter ${names[i]['name']}",
                      type: TextInputType.multiline,
                      fn: (val) => true,
                      doIt: false,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      if (key1.currentState!.validate() == true &&
                          key2.currentState!.validate() == true) {
                        CacheHelper.saveData(
                            key: names[0]["name"], value: names[0]["cont"].text);
                        CacheHelper.saveData(
                            key: names[1]["name"], value: names[1]["cont"].text);
                        Navigator.pushNamed(
                            context,
                            type != "Fighter"
                                ? FirstScreen.routeName
                                : FighterS1.routeName);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Data saved successfully"),
                        ));
                      }
                    },
                    color: buttonColor,
                    padding: const EdgeInsets.all(padding),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonRadius),
                    ),
                    child: const Text(
                      "Save Data",
                      style: TextStyle(color: Colors.white, fontSize: labelSize),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      CacheHelper.clearAllData();
                      Navigator.pushReplacementNamed(context, Home.routeName);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Logout successfully"),
                      ));
                    },
                    color: buttonColor,
                    padding: const EdgeInsets.all(padding),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonRadius),
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: labelSize),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(padding),
                  child: MaterialButton(
                    onPressed: () {
                      if (key1.currentState!.validate() == true &&
                          key2.currentState!.validate() == true) {
                        CacheHelper.saveData(
                            key: names[0]["name"], value: names[0]["cont"].text);
                        CacheHelper.saveData(
                            key: names[1]["name"], value: names[1]["cont"].text);
                        Navigator.pushReplacementNamed(context, Data.routeName);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Name remade successfully"),
                        ));
                      }
                    },
                    color: buttonColor,
                    padding: const EdgeInsets.all(padding),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonRadius),
                    ),
                    child: const Text(
                      "Save direct",
                      style: TextStyle(color: Colors.white, fontSize: labelSize),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
