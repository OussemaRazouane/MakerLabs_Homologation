import 'package:flutter/material.dart';
import 'package:makerlab/DataBase/cache_helper.dart';
import 'package:makerlab/constants/constant.dart';
import 'package:makerlab/widgets/custom_fi.dart';

// ignore: must_be_immutable
class PoidsLong extends StatefulWidget {
  final String name1;
  final String name2;
  final String name3;
  final String name4;
  final TextEditingController val1 ;
  final GlobalKey<FormState> key1 ;
  final TextEditingController val2 ;
  final GlobalKey<FormState> key2 ;
  final TextEditingController val3 ;
  final GlobalKey<FormState> key3 ;
  final TextEditingController val4 ;
  final GlobalKey<FormState> key4 ;
  PoidsLong(
      {super.key,
      required this.name1,
      required this.name2,
      required this.name3,
      required this.name4,
      required this.val1, 
      required this.key1,
      required this.val2, 
      required this.key2, 
      required this.val3, 
      required this.key3, 
      required this.val4, 
      required this.key4,
      });
  @override
  State<PoidsLong> createState() => _PoidsLongState();
}

class _PoidsLongState extends State<PoidsLong> {
  
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
              txtKey: widget.key1,
              value: widget.val1,
              name: widget.name1,
              type: TextInputType.number,
              fn: (val) => val <= 10 && val >= 0,
              doIt: false,
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
              txtKey: widget.key2,
              value: widget.val2,
              name: widget.name2,
              type: TextInputType.number,
              fn: (val) => val <= 10 && val >= 0,
              doIt: false,
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
              txtKey: widget.key3,
              value: widget.val3,
              name: widget.name3,
              type: TextInputType.number,
              fn: (val) => val <= 10 && val >= 0,
              doIt: false,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.name4,
              style: const TextStyle(fontSize: labelSize, color: textColor),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              txtKey: widget.key4,
              value: widget.val4,
              name: widget.name4,
              type: TextInputType.number,
              fn: (val) => val <= 10 && val >= 0,
              doIt: false,
            ),
            
            
            
          ],
        ),
      ),
    );
  }
}
