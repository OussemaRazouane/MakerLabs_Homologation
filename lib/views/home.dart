import 'package:flutter/material.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/name_screen.dart';
import 'package:makerlab/widgets/poids_long.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static String routeName = "Home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  final TextEditingController val1 = TextEditingController();
  final GlobalKey<FormState> key1 = GlobalKey();
  final TextEditingController val2 = TextEditingController();
  final GlobalKey<FormState> key2 = GlobalKey();
  final TextEditingController val3 = TextEditingController();
  final GlobalKey<FormState> key3 = GlobalKey();
  final TextEditingController val4 = TextEditingController();
  final GlobalKey<FormState> key4 = GlobalKey();
  late String type;
  bool obscure = true;
  Map<String,String> motDePasse = {
    "All roads":"Allroadsistichomo2025", 
    "Fighter":"Fighterhomo2025", 
    "Line follower":"Linefollowerhomo2025", 
    "Maze":"RobotMazehomo2025", 
    "Junior":"Juniorhomo2025"
  };
  List<String> types = [
    "All roads",
    "Line follower",
    "Maze",
    "Fighter",
    "Junior"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Homologation",
          style: TextStyle(fontSize: titleSize, color: textColor),
        ),
        centerTitle: true,
        backgroundColor: bgColorApp,
      ),
      backgroundColor: bgColorGen,
      body: Center(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: DropdownMenu(
                            helperText: "Select the type",
                            leadingIcon: const Icon(Icons.keyboard_alt_rounded,
                                color: textColor),
                            textStyle: const TextStyle(
                                color: textColor, fontWeight: FontWeight.bold),
                            inputDecorationTheme: InputDecorationTheme(
                              focusColor:
                                  const Color.fromARGB(255, 214, 197, 141),
                              hoverColor:
                                  const Color.fromARGB(255, 203, 192, 158),
                              labelStyle: const TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                              hintStyle: const TextStyle(color: textColor),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: textColor, width: 2.5),
                                borderRadius:
                                    BorderRadius.circular(fieldRadius),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: textColor, width: 2.5),
                                borderRadius:
                                    BorderRadius.circular(fieldRadius),
                              ),
                            ),
                            menuStyle: MenuStyle(
                                backgroundColor: const WidgetStatePropertyAll(
                                    Color.fromARGB(255, 170, 162, 139)),
                                padding: const WidgetStatePropertyAll(
                                    EdgeInsets.only(
                                        left: 20, right: 20, top: 15)),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )),
                            enableFilter: true,
                            onSelected: (val) {
                              setState(() {
                                type = val!;
                              });
                            },
                            dropdownMenuEntries: <DropdownMenuEntry<String>>[
                              for (int i = 0; i < types.length; i++)
                                DropdownMenuEntry(
                                  value: types[i],
                                  label: types[i],
                                  style: const ButtonStyle(
                                    alignment: Alignment.center,
                                    textStyle: WidgetStatePropertyAll(TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold)),
                                  ),
                                )
                            ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: key,
                        child: TextFormField(
                          controller: password,
                          obscureText: obscure,
                          decoration: InputDecoration(
                            focusColor: fieldColor,
                            labelStyle: const TextStyle(
                                color: textColor, fontWeight: FontWeight.bold),
                            hintStyle: const TextStyle(color: textColor),
                            prefixIcon: const Icon(
                              Icons.password_outlined,
                              color: textColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(fieldRadius),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: textColor, width: 2.5),
                              borderRadius: BorderRadius.circular(fieldRadius),
                            ),
                            labelText: "Password",
                            hintText: "Enter your Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              icon: !obscure
                                  ? const Icon(Icons.visibility,
                                      color: textColor)
                                  : const Icon(Icons.visibility_off,
                                      color: textColor),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            } else if (value!=motDePasse[type]) {
                              return "Sheik the Password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      PoidsLong(
                        name1: "MaxWeight",
                        val1: val1,
                        key1: key1,
                        name2: "MaxLength",
                        val2: val2,
                        key2: key2,
                        name3: "MaxWidth",
                        val3: val3,
                        key3: key3,
                        name4: "MaxHeight",
                        val4: val4,
                        key4: key4,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: MaterialButton(
                          onPressed: () {
                            if (key.currentState!.validate() == true &&
                                key1.currentState!.validate() == true &&
                                key2.currentState!.validate() == true &&
                                key3.currentState!.validate() == true &&
                                key4.currentState!.validate() == true) {
                              CacheHelper.saveData(
                                  key: "MaxWeight", value: val1.text);
                              CacheHelper.saveData(
                                  key: "MaxLength", value: val2.text);
                              CacheHelper.saveData(
                                  key: "MaxWidth", value: val3.text);
                              CacheHelper.saveData(
                                  key: "MaxHeight", value: val4.text);

                              CacheHelper.saveData(key: "Type", value: type);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Login successfully"),
                              ));
                              Navigator.pushReplacementNamed(
                                  context, NameScreen.routeName);
                            }
                          },
                          color: buttonColor,
                          padding: const EdgeInsets.all(padding),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ]),
              ),
            )),
      ),
    );
  }
}
