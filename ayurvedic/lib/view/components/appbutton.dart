// ignore_for_file: must_be_immutable

import 'package:ayurvedic/view/components/apptext.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppButton extends StatelessWidget {
   AppButton({
    super.key,this.child,required this.onPressed,this.btncolor,this.textcolor
  });
  Widget? child;
  Color? btncolor,textcolor;
  Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height:50 ,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:  MaterialStatePropertyAll(btncolor?? kbtncolor),
          shadowColor: const MaterialStatePropertyAll(ktransparent),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.52),
          ))
        ),
        onPressed: onPressed, child:child?? AppText(text: 'Login',color:textcolor?? kwhite,size: 17,letterspace: 0.1,weight: FontWeight.w600,)));
  }
}