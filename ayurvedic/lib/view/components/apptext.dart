// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
   AppText({
    super.key,this.color,required this.text,this.size,this.letterspace,this.weight,this.family
  });
  String text;
  String? family;
  Color? color;
  double? size,letterspace;
  FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        letterSpacing: letterspace,
        fontFamily: family??'',
      ),
    );
  }
}

