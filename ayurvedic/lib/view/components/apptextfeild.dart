// ignore_for_file: must_be_immutable

import 'package:ayurvedic/utils/extensions/space_ext.dart';
import 'package:ayurvedic/utils/helper/helper_screensize.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppTextFeild extends StatelessWidget {
  AppTextFeild(
      {super.key, required this.controller, this.label, this.hinttext,this.isobsecure,this.type,this.height,this.width,this.prefix,this.suffix,this.readonly});
  TextEditingController controller;
  String? label, hinttext;
  TextInputType? type;
  bool? isobsecure,readonly;
  Widget? suffix,prefix;
  double?height,width;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SizedBox(
      width:width?? ScreenUtil.screenWidth,
      height:height?? 79.90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        (label==null)?0.hBox:  Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 8),
            child: Text(
              label??'',
              style: const TextStyle(
                  color: kloginhead, fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              obscureText:isobsecure?? false,
              controller: controller,
              keyboardType:type?? TextInputType.text,
              readOnly: readonly??false,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: ktextfeildfill.withOpacity(0.25),
                  hintText: hinttext,
                  prefix: prefix,
                  suffix: suffix,
                  
                  hintStyle: TextStyle(
                      color: kblack.withOpacity(0.4),
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      fontFamily: ''),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.53),
                    borderSide:
                        BorderSide(color: kblack.withOpacity(0.1), width: 0.85),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.53),
                    borderSide:
                        BorderSide(color: kblack.withOpacity(0.1), width: 0.85),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.53),
                    borderSide:
                        BorderSide(color: kblack.withOpacity(0.1), width: 0.85),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
