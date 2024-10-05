import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/name_screen.dart';

class Data extends StatefulWidget {
  const Data({super.key});
  static String routeName = "DataScreen";

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  String type = CacheHelper.getData(key: "Type");
  List<String> list = [];
  @override
  void initState() {
    super.initState();
    if (type != "Fighter") {
      list = [
        "Robot name",
        "Leader name",
        "Carte de puissance",
        "Carte de commande",
        "Conception mecanique",
        "Conception electrique",
        "Poids",
        "Langeur",
        "Largeur",
        "Hauteur",
      ];
    } else {
      list = [
        "Robot name",
        "Leader name",
        "Mobile robot during certification",
        "Active weapon during certification",
        "Presence of electronic design",
        "Presence of mechanical design",
        "Robot Safety cectrical and mechanical",
        "Power board created by the team",
        "Control board created by the team",
        "Remote control board created by the team",
        "Emergency button accessible",
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference colRef ;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            type,
            style: const TextStyle(fontSize: titleSize),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(padding + 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(padding + 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < list.length; i++)
                            Row(
                              children: [
                                Text(
                                  "${list[i]} : ",
                                  style: const TextStyle(fontSize: titleSize),
                                ),
                                Text(
                                  CacheHelper.getData(key: list[i]),
                                  style: const TextStyle(fontSize: titleSize),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          if (type == "Fighter") {
                            colRef = FirebaseFirestore.instance.collection("Fighter");
                            colRef.add({
                              list[0]: CacheHelper.getData(key: list[0]).toString(),
                              list[1]: CacheHelper.getData(key: list[1]).toString(),
                              list[2]: int.tryParse(CacheHelper.getData(key: list[2])),
                              list[3]: int.tryParse(CacheHelper.getData(key: list[3]).toString()),
                              list[4]: int.tryParse(CacheHelper.getData(key: list[4]).toString()),
                              list[5]: int.tryParse(CacheHelper.getData(key: list[5]).toString()),
                              list[6]: int.tryParse(CacheHelper.getData(key: list[6]).toString()),
                              list[7]: int.tryParse(CacheHelper.getData(key: list[7]).toString()),
                              list[8]: int.tryParse(CacheHelper.getData(key: list[8]).toString()),
                              list[9]: int.tryParse(CacheHelper.getData(key: list[9]).toString()),
                              list[10]: int.tryParse(CacheHelper.getData(key: list[10]).toString()),
                            });
                          }else {
                            colRef = FirebaseFirestore.instance.collection("Basic");
                            colRef.add({
                              "Type":type,
                                                            list[0]: CacheHelper.getData(key: list[0]).toString(),
                              list[1]: CacheHelper.getData(key: list[1]).toString(),
                              list[2]: int.tryParse(CacheHelper.getData(key: list[2])),
                              list[3]: int.tryParse(CacheHelper.getData(key: list[3]).toString()),
                              list[4]: int.tryParse(CacheHelper.getData(key: list[4]).toString()),
                              list[5]: int.tryParse(CacheHelper.getData(key: list[5]).toString()),
                              list[6]: int.tryParse(CacheHelper.getData(key: list[6]).toString()),
                              list[7]: int.tryParse(CacheHelper.getData(key: list[7]).toString()),
                              list[8]: int.tryParse(CacheHelper.getData(key: list[8]).toString()),
                              list[9]: int.tryParse(CacheHelper.getData(key: list[9]).toString()),
                              
                            });
                          }
                          for (String k in list) {
                            CacheHelper.removeData(key: k);
                          }
                          Navigator.pushReplacementNamed(
                              context, NameScreen.routeName);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Data saved in FireBse successfully"),
                          ));
                        },
                        color: buttonColor,
                        padding: const EdgeInsets.all(padding),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(buttonRadius),
                        ),
                        child: const Text(
                          "Save in FireBase",
                          style: TextStyle(
                              color: Colors.white, fontSize: labelSize),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, NameScreen.routeName);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Resolve the problem"),
                          ));
                        },
                        color: buttonColor,
                        padding: const EdgeInsets.all(padding),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(buttonRadius),
                        ),
                        child: const Text(
                          "Restart",
                          style: TextStyle(
                              color: Colors.white, fontSize: labelSize),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ));
  }
}
