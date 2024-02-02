// ignore_for_file: must_be_immutable

import 'package:ayurvedic/utils/colors.dart';
import 'package:ayurvedic/utils/extensions/space_ext.dart';
import 'package:ayurvedic/view/components/apptext.dart';
import 'package:flutter/material.dart';

import '../../utils/helper/helper_screensize.dart';

class MyAppDropDown extends StatelessWidget {
  MyAppDropDown(
      {super.key,
      required this.onChange,
      required this.items,
      this.value,
      this.hint,
      this.focusnode,
      this.height,
      this.width,
      this.label});
  Function(String?) onChange;
  List<String> items;
  String? value, hint, label;
  FocusNode? focusnode;
  double? width, height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? ScreenUtil.screenWidth,
      height: height ?? 79.90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (label == null)
              ? 0.hBox
              : Padding(
                  padding: const EdgeInsets.only(bottom: 6, left: 8),
                  child: Text(
                    label ?? '',
                    style: const TextStyle(
                        color: kloginhead,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
          Container(
              decoration: BoxDecoration(
                  color: ktextfeildfill.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: kblack.withOpacity(0.1), width: 0.85)),
              height: 50,
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: DropdownButton(
                        icon: Icon(Icons.keyboard_arrow_down_outlined,color: ktextgreen,),
                        isDense: true,
                        isExpanded: true,
                        value: value,
                        focusNode: focusnode,
                        autofocus: true,
                        hint: AppText(
                            text: hint ?? 'Select',
                            color: kblack.withOpacity(0.4),
                            weight: FontWeight.w300,
                            size: 14,
                            family: ''),
                        underline: Container(),
                        items: items.map((list) {
                          return DropdownMenuItem(
                            value: list,
                            child: AppText(
                              text: list,
                            ),
                          );
                        }).toList(),
                        onChanged: onChange,
                      )))),
        ],
      ),
    );
  }
}
