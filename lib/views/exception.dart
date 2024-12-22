import 'package:flutter/material.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/views/name_screen.dart';

class ExcpScreen extends StatefulWidget {
  const ExcpScreen({super.key});
  static String routeName = "ExceptionScreen";
  @override
  State<ExcpScreen> createState() => _ExcpScreenState();
}

class _ExcpScreenState extends State<ExcpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          "Exception",
          style:TextStyle(fontSize: titleSize, color: textColor),
        ),
        centerTitle: true,
        backgroundColor: bgColorApp,
      ),
      backgroundColor: bgColorGen,
      body:Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "An error occurred. Please return to the name screen on clicking to the arrow .",
                style: TextStyle(fontSize: 23, color: fieldColor),textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              IconButton(
                icon:const Icon(Icons.arrow_back,size:50,color:fieldColor),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                                context, NameScreen.routeName);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}