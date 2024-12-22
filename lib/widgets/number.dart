import 'package:flutter/material.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/widgets/custom_fi.dart';

// ignore: must_be_immutable
class NumberScreen extends StatefulWidget {
  NumberScreen(
      {super.key,
      required this.name1,
      required this.name2,
      required this.name3,
      this.name4, 
      required this.routeForward, this.maxName1=10, this.maxName2=10, this.maxName3=10, this.maxName4=10});
  final String name1;
  final String name2;
  final String name3;
  final double maxName1;
  final double maxName2;
  final double maxName3;
  final double maxName4;
  String? name4;
  final String routeForward;

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  TextEditingController val1 = TextEditingController();
  GlobalKey<FormState> key1 = GlobalKey();
  TextEditingController val2 = TextEditingController();
  GlobalKey<FormState> key2 = GlobalKey();
  TextEditingController val3 = TextEditingController();
  GlobalKey<FormState> key3 = GlobalKey();
  TextEditingController val4 = TextEditingController();
  GlobalKey<FormState> key4 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.name1,
              style: const TextStyle(fontSize: labelSize, color: textColor),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              txtKey: key1,
              value: val1,
              name: widget.name1,
              type: TextInputType.number,
              fn: (val) => val <= widget.maxName1 && val >= 0,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.name2,
              style: const TextStyle(fontSize: labelSize, color: textColor),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              txtKey: key2,
              value: val2,
              name: widget.name2,
              type: TextInputType.number,
              fn: (val) => val <= widget.maxName2 && val >= 0,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.name3,
              style: const TextStyle(fontSize: labelSize, color: textColor),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              txtKey: key3,
              value: val3,
              name: widget.name3,
              type: TextInputType.number,
              fn: (val) => val <= widget.maxName3 && val >= 0,
            ),
            const SizedBox(
              height: 30,
            ),
            if(widget.name4 != null)
              Column(
                children: [
                  Text(
                    widget.name4!,
                    style: const TextStyle(fontSize: labelSize, color: textColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomField(
                    txtKey: key4,
                    value: val4,
                    name: widget.name4!,
                    type: TextInputType.number,
                    fn: (val) => val <= widget.maxName4 && val >= 0,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  if (key1.currentState!.validate() == true &&
                      key2.currentState!.validate() == true &&
                      key3.currentState!.validate() == true &&
                      (widget.name4!=null?key4.currentState!.validate() == true:true)) {
                    CacheHelper.saveData(key: widget.name1, value:val1.text);
                    CacheHelper.saveData(key: widget.name2, value: val2.text);
                    CacheHelper.saveData(key: widget.name3, value: val3.text);
                    widget.name4!=null?CacheHelper.saveData(key: widget.name4!, value: val4.text):null;
                    Navigator.pushNamed(context, widget.routeForward);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  backgroundColor: Colors.green,
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
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: labelSize),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
