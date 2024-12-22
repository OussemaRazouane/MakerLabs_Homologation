import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/name_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Data extends StatefulWidget {
  const Data({super.key});
  static String routeName = "DataScreen";

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  String type = CacheHelper.getData(key: "Type");
  bool _isUploading = false;
  List<String> list = [];
  late CollectionReference colRef;
  Future<String?> uploadImageToFirebase(Uint8List? img) async {
    if (img == null) return null;
    setState(() {
      _isUploading = true;
    });

    // Create a unique file name for the image
    String fileName =
        'images/${DateTime.now().millisecondsSinceEpoch.toString()}';

    try {
      // Upload the image to Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageReference.putData(img);
      await uploadTask.whenComplete(() => null);

      // Get the URL of the uploaded file
      return await storageReference.getDownloadURL();
    } catch (e) {
      log("Error uploading image: $e");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    if (type != "Fighter") {
      list = [
        "Robot name",
        "Leader name",
        "Power board",
        "Command board",
        "Mechanical design",
        "Electrical design",
        "Weight",
        "Length",
        "Width",
        "Height",
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
    CollectionReference colRef;
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
        body: Center(
          child: _isUploading
              ? const CircularProgressIndicator(color:bgColorApp)
              : SingleChildScrollView(
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
                                  Row(
                                    children: [
                                      const Text(
                                        "Image N°1 : ",
                                        style: TextStyle(
                                            fontSize: titleSize,
                                            color:
                                                Color.fromARGB(255, 53, 40, 3)),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: img1 == null
                                            ? null
                                            : Image(
                                                height: 200,
                                                width: 200,
                                                image: MemoryImage(img1!),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Image N°2 : ",
                                        style: TextStyle(
                                            fontSize: titleSize,
                                            color:
                                                Color.fromARGB(255, 53, 40, 3)),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: img1 == null
                                            ? null
                                            : Image(
                                                height: 200,
                                                width: 200,
                                                image: MemoryImage(img2!),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DataTable(
                                    columns: const [
                                      DataColumn(label: Text("Name")),
                                      DataColumn(label: Text("Value")),
                                    ],
                                    rows:[
                                      for (int i = 0; i < list.length; i++)
                                        DataRow(cells: [
                                          DataCell(Text(
                                            "${list[i]} : ",
                                            style: const TextStyle(
                                                fontSize: titleSize,
                                                color: Color.fromARGB(
                                                    255, 53, 40, 3)),
                                          ),),
                                          DataCell(Text(
                                            CacheHelper.getData(key: list[i]),
                                            style: const TextStyle(
                                                fontSize: titleSize,
                                                color: Color.fromARGB(
                                                    255, 69, 52, 0))
                                            )
                                          ),
                                          
                                        ]),
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
                                onPressed: () async{
                                  Navigator.pushReplacementNamed(
                                      context, NameScreen.routeName);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Resolve the problem"),
                                  ));
                                },
                                color: buttonColor,
                                padding: const EdgeInsets.all(padding),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(buttonRadius),
                                ),
                                child: const Text(
                                  "Restart",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: labelSize),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () async{
                                  String? firstimg=await uploadImageToFirebase(img1);
                                  String? secondimg=await uploadImageToFirebase(img2);
                                  if (type == "Fighter") {
                                    colRef = FirebaseFirestore.instance
                                        .collection("Fighter");
                                    colRef.add({
                                      "Round":1,
                                      list[0]: CacheHelper.getData(key: list[0])
                                          .toString(),
                                      list[1]: CacheHelper.getData(key: list[1])
                                          .toString(),
                                      list[2]: int.tryParse(
                                          CacheHelper.getData(key: list[2])),
                                      list[3]: int.tryParse(
                                          CacheHelper.getData(key: list[3])
                                              .toString()),
                                      list[4]: int.tryParse(
                                          CacheHelper.getData(key: list[4])
                                              .toString()),
                                      list[5]: int.tryParse(
                                          CacheHelper.getData(key: list[5])
                                              .toString()),
                                      list[6]: int.tryParse(
                                          CacheHelper.getData(key: list[6])
                                              .toString()),
                                      list[7]: int.tryParse(
                                          CacheHelper.getData(key: list[7])
                                              .toString()),
                                      list[8]: int.tryParse(
                                          CacheHelper.getData(key: list[8])
                                              .toString()),
                                      list[9]: int.tryParse(
                                          CacheHelper.getData(key: list[9])
                                              .toString()),
                                      list[10]: int.tryParse(
                                          CacheHelper.getData(key: list[10])
                                              .toString()),
                                      "First image":firstimg,
                                      "Second image": secondimg,
                                    });
                                  } else {
                                    colRef = FirebaseFirestore.instance
                                        .collection(type);
                                    if(["Line follower","Maze"].contains(type))
                                    {  colRef.add({
                                        "Trials":[{"Time":"0:000","Descalifier":false}],
                                        list[0]: CacheHelper.getData(key: list[0])
                                            .toString(),
                                        list[1]: CacheHelper.getData(key: list[1])
                                            .toString(),
                                        list[2]: int.tryParse(
                                            CacheHelper.getData(key: list[2])),
                                        list[3]: int.tryParse(
                                            CacheHelper.getData(key: list[3])
                                                .toString()),
                                        list[4]: int.tryParse(
                                            CacheHelper.getData(key: list[4])
                                                .toString()),
                                        list[5]: int.tryParse(
                                            CacheHelper.getData(key: list[5])
                                                .toString()),
                                        list[6]: double.tryParse(
                                            CacheHelper.getData(key: list[6])
                                                .toString()),
                                        list[7]: double.tryParse(
                                            CacheHelper.getData(key: list[7])
                                                .toString()),
                                        list[8]: double.tryParse(
                                            CacheHelper.getData(key: list[8])
                                                .toString()),
                                        list[9]: double.tryParse(
                                            CacheHelper.getData(key: list[9])
                                                .toString()),
                                        "First image": firstimg,
                                        "Second image": secondimg,
                                      });
                                    }else{
                                      colRef.add({
                                        "Round":1,
                                        list[0]: CacheHelper.getData(key: list[0])
                                            .toString(),
                                        list[1]: CacheHelper.getData(key: list[1])
                                            .toString(),
                                        list[2]: int.tryParse(
                                            CacheHelper.getData(key: list[2])),
                                        list[3]: int.tryParse(
                                            CacheHelper.getData(key: list[3])
                                                .toString()),
                                        list[4]: int.tryParse(
                                            CacheHelper.getData(key: list[4])
                                                .toString()),
                                        list[5]: int.tryParse(
                                            CacheHelper.getData(key: list[5])
                                                .toString()),
                                        list[6]: double.tryParse(
                                            CacheHelper.getData(key: list[6])
                                                .toString()),
                                        list[7]: double.tryParse(
                                            CacheHelper.getData(key: list[7])
                                                .toString()),
                                        list[8]: double.tryParse(
                                            CacheHelper.getData(key: list[8])
                                                .toString()),
                                        list[9]: double.tryParse(
                                            CacheHelper.getData(key: list[9])
                                                .toString()),
                                        "First image": firstimg,
                                        "Second image": secondimg,
                                      });
                                    }
                                  }
                                  setState(() {
                                    _isUploading = false;
                                  });
                                  for (String k in list) {
                                    CacheHelper.removeData(key: k);
                                  }
                                  Navigator.pushReplacementNamed(
                                      context, NameScreen.routeName);
                                  img1 = null;
                                  img2 = null;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                        "Data saved in FireBse successfully"),
                                  ));
                                },
                                
                                style: ButtonStyle(
                                  overlayColor:
                                      const WidgetStatePropertyAll(buttonColor),
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsetsDirectional.all(padding)),
                                  side: const WidgetStatePropertyAll(
                                      BorderSide(color: textColor, width: 1.8)),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(buttonRadius),
                                    ),
                                  )
                                ),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: labelSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                
                              ),
                            ],
                          )
                        ],
                      )),
                ),
        ));
  }
}
