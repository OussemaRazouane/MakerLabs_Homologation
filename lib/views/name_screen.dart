import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';

import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/basic/first_screen.dart';
import 'package:makerlab/views/data_sheet.dart';
import 'package:makerlab/views/exception.dart';
import 'package:makerlab/views/fighter/first_screen.dart';
import 'package:makerlab/views/home.dart';
import 'package:makerlab/widgets/custom_fi.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});
  static String routeName = "NameScreen";
  @override
  State<NameScreen> createState() => _NameScreenState();
}

Uint8List? img1;
Uint8List? img2;

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

  Future<Uint8List?> pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img == null) {
      return null;
    } else {
      Img.Image? image = Img.decodeImage(File(img.path).readAsBytesSync());

      // Resize or compress the image (width: 800px, quality: 85)
      Img.Image resizedImage = Img.copyResize(image!, width: 600, height: 600);
      return Uint8List.fromList(Img.encodeJpg(resizedImage, quality: 100));
    }
  }

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
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Image N°1 :",
                  style: TextStyle(fontSize: labelSize, color: textColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: textColor,
                        size: 60,
                      ),
                      onPressed: () async {
                        var img = await pickImage();
                        setState(() {
                          img1 = img;
                        });
                      },
                    ),
                  ],
                ),
                const Text(
                  "Image N°2 :",
                  style: TextStyle(fontSize: labelSize, color: textColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: img2 == null
                          ? null
                          : Image(
                              height: 200,
                              width: 200,
                              image: MemoryImage(img2!),
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: textColor,
                        size: 60,
                      ),
                      onPressed: () async {
                        var img = await pickImage();
                        setState(() {
                          img2 = img;
                        });
                      },
                    ),
                  ],
                ),
                for (int i = 0; i < names.length; i++)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        names[i]["name"],
                        style: const TextStyle(
                            fontSize: labelSize, color: textColor),
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
                        CacheHelper.clearAllData();
                        Navigator.pushReplacementNamed(context, Home.routeName);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
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
                        style:
                            TextStyle(color: Colors.white, fontSize: labelSize),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (key1.currentState!.validate() == true &&
                            key2.currentState!.validate() == true) {
                          CacheHelper.saveData(
                              key: names[0]["name"],
                              value: names[0]["cont"].text);
                          CacheHelper.saveData(
                              key: names[1]["name"],
                              value: names[1]["cont"].text);
                          Navigator.pushNamed(
                              context,
                              type != "Fighter"
                                  ? FirstScreen.routeName
                                  : FighterS1.routeName);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Data saved successfully"),
                          ));
                        }
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
                          )),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                            color: textColor,
                            fontSize: labelSize,
                            fontWeight: FontWeight.bold),
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
                          if (CacheHelper.containKey(
                                  key: "Mobile robot during certification") ||
                              CacheHelper.containKey(
                                  key: "Carte de puissance")) {
                            CacheHelper.saveData(
                                key: names[0]["name"],
                                value: names[0]["cont"].text);
                            CacheHelper.saveData(
                                key: names[1]["name"],
                                value: names[1]["cont"].text);
                            Navigator.pushReplacementNamed(
                                context, Data.routeName);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Name remade successfully"),
                            ));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExcpScreen()));
                          }
                        }
                      },
                      color: buttonColor,
                      padding: const EdgeInsets.all(padding),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(buttonRadius),
                      ),
                      child: const Text(
                        "Data verification",
                        style:
                            TextStyle(color: Colors.white, fontSize: labelSize),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
