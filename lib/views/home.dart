import 'package:flutter/material.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/name_screen.dart';


class Home extends StatefulWidget {
  const Home({super.key});
  static String routeName = "Home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  late String type;
  bool obscure = true;
  List<String> types=["Tous terrain","Suiver de linge","Maze","Fighter","Junior"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Homologation",
          style:  TextStyle(fontSize: titleSize,color: textColor),
        ),
        centerTitle: true,
        backgroundColor: bgColorApp,
      ),
      backgroundColor: bgColorGen,
      body:Center(
        child:
          SingleChildScrollView(
            physics:const BouncingScrollPhysics() ,
            child:Padding(
              padding:const EdgeInsets.all(10),
              child:Center(
                  child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Form(
                          key:key,
                          child: TextFormField(
                            controller:password ,
                            obscureText:obscure ,
                            decoration: InputDecoration(
                              focusColor:fieldColor,
                              labelText: "Password",
                              hintText: "Enter your Password",
                              suffixIcon:IconButton(
                                onPressed:(){
                                  setState(() {
                                    obscure =!obscure;
                                  });
                                } ,
                                icon:!obscure?const Icon(Icons.visibility):const Icon(Icons.visibility_off) ,
                              ) ,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(fieldRadius),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is required";
                              } else if (value.toUpperCase()!=type.toUpperCase()) {
                                return "Sheik the Password";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: DropdownMenu(
                            helperText:"Select the type" ,
                            enableFilter: true,
                            onSelected: (val){
                              setState(() {
                                type=val!;
                              });
                            },
                            dropdownMenuEntries:<DropdownMenuEntry<String>>[
                              for(int i=0;i<types.length;i++)
                                DropdownMenuEntry(
                                  value:types[i],
                                  label:types[i],
                                )
                            ]
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: MaterialButton(
                              onPressed: () {
                                if (key.currentState!.validate() == true) {
                                  CacheHelper.saveData(key: "Type", value: type);
                                  Navigator.pushReplacementNamed(context, NameScreen.routeName);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Login successfully"),
                                  ));
                                }
                              },
                              color: buttonColor,
                              padding: const EdgeInsets.all(padding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Save Data",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                        ),
                      ]
                    ),
              ),
            )
          ),
      ),
    );
  }
}