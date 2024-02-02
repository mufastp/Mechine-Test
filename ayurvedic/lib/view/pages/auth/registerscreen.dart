import 'dart:convert';
import 'dart:developer';

import 'package:ayurvedic/model/branchlistmodel.dart';
import 'package:ayurvedic/model/treatmentlistmodel.dart';
import 'package:ayurvedic/utils/extensions/space_ext.dart';
import 'package:ayurvedic/utils/helper/helper_screensize.dart';
import 'package:ayurvedic/view/components/appbutton.dart';
import 'package:ayurvedic/view/components/apptext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import '../../../controller/service/url.dart';
import '../../../utils/colors.dart';
import '../../../utils/string.dart';
import '../../components/appdropdown.dart';
import '../../components/apptextfeild.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  BranchList? branclist;
  TreatmentList? treatlist;
  bool isLoading = true;
  String? branch, treat;
  TextEditingController nameCtrl = TextEditingController(),
      whatsCtrl = TextEditingController(),
      addCtrl = TextEditingController(),
      locaCtrl = TextEditingController(),
      branchCtrl = TextEditingController(),
      totalCtrl = TextEditingController(),
      discCtrl = TextEditingController(),
      advanCtrl = TextEditingController(),
      maleCtrl = TextEditingController(text: '0'),
      femaleCtrl = TextEditingController(text: '0'),
      dmaleCtrl = TextEditingController(),
      dfemaleCtrl = TextEditingController(),
      balanCtrl = TextEditingController();
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    branclist = await getbranchlist();
    treatlist = await gettreatlist();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        color: kwhite,
        width: ScreenUtil.screenWidth,
        height: ScreenUtil.screenHeight,
        child: const Center(
          child: CircularProgressIndicator(
            color: ktextgreen,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                'assets/images/bell.svg',
              ),
            )
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(54.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: kblack.withOpacity(0.2)))),
                child: Column(
                  children: [
                    20.hBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Row(
                        children: [
                          AppText(
                            text: 'Register',
                            color: kloginhead,
                            size: 24,
                            weight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                20.hBox,
                AppTextFeild(
                    label: "Name",
                    hinttext: "Enter your Full Name",
                    controller: nameCtrl),
                20.hBox,
                AppTextFeild(
                    type: TextInputType.number,
                    label: "Whatsapp Number",
                    hinttext: "Enter your whatsapp number",
                    controller: whatsCtrl),
                20.hBox,
                AppTextFeild(
                    label: "Address ",
                    hinttext: "Enter your full address",
                    controller: addCtrl),
                20.hBox,
                AppTextFeild(
                    label: "Location",
                    hinttext: "Enter Full Name",
                    controller: locaCtrl),
                20.hBox,
                MyAppDropDown(
                  value: branch,
                  items: branclist!.branches!
                      .map((e) => e.name.toString())
                      .toList(),
                  onChange: (value) {
                    branchCtrl.text = value ?? '';
                    branch = value ?? '';
                    setState(() {});
                  },
                  label: "Branch",
                  hint: "Select the Branch",
                ),
                20.hBox,
                const Row(
                  children: [
                    Text(
                      "Tretment",
                      style: TextStyle(
                          color: kloginhead,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Container(
                  width: ScreenUtil.screenWidth,
                  decoration: BoxDecoration(
                    color: kcontainergrey,
                    borderRadius: BorderRadius.circular(8.53),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: "1.  Couple Combo Package",
                              color: kblack,
                              weight: FontWeight.w500,
                              size: 18,
                            ),
                            SvgPicture.asset(
                              'assets/images/redclose.svg',
                            ),
                          ],
                        ),
                        10.hBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AppText(
                              text: 'Male',
                              color: ktextgreen,
                              size: 16,
                              weight: FontWeight.w400,
                            ),
                            Container(
                              width: 44,
                              height: 26,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: kblack.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            AppText(
                              text: 'Female',
                              color: ktextgreen,
                              size: 16,
                              weight: FontWeight.w400,
                            ),
                            Container(
                              width: 44,
                              height: 26,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: kblack.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/images/editic.svg',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                10.hBox,
                AppButton(
                    btncolor: kbtnlight.withOpacity(0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: kblack,
                        ),
                        AppText(
                            text: 'Add Treatment',
                            color: kblack,
                            size: 17,
                            letterspace: 0.1,
                            weight: FontWeight.w600,
                            family: 'Poppins'),
                      ],
                    ),
                    onPressed: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                contentPadding: const EdgeInsets.all(0),
                                content: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        30.hBox,
                                        MyAppDropDown(
                                          value: treat,
                                          items: treatlist!.treatments!
                                              .map((e) => e.name.toString())
                                              .toList(),
                                          onChange: (value) {
                                            treat = value;
                                            setState(() {});
                                          },
                                          label: "Choose Treatment",
                                          hint: "Choose Prefered treatment",
                                        ),
                                        20.hBox,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: AppTextFeild(
                                              controller: dmaleCtrl,
                                              hinttext: 'Male',
                                              readonly: true,
                                            )),
                                            Expanded(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: kbtncolor),
                                                  width: 50,
                                                  height: 50,
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.minimize,
                                                    color: kwhite,
                                                  )),
                                                ),
                                                Expanded(
                                                    child: AppTextFeild(
                                                  controller: maleCtrl,
                                                )),
                                                SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: ElevatedButton(
                                                        onPressed: () {},
                                                        child: const Icon(
                                                          Icons.add,
                                                          color: kwhite,
                                                        )))
                                              ],
                                            )),
                                          ],
                                        ),
                                        20.hBox,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: AppTextFeild(
                                              controller: dfemaleCtrl,
                                              hinttext: 'FeMale',
                                              readonly: true,
                                            )),
                                            Expanded(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: kbtncolor),
                                                  width: 50,
                                                  height: 50,
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.minimize,
                                                    color: kwhite,
                                                  )),
                                                ),
                                                Expanded(
                                                    child: AppTextFeild(
                                                  controller: femaleCtrl,
                                                )),
                                                SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: ElevatedButton(
                                                        onPressed: () {},
                                                        child: const Icon(
                                                          Icons.add,
                                                          color: kwhite,
                                                        )))
                                              ],
                                            )),
                                          ],
                                        ),
                                        20.hBox,
                                        AppButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: AppText(
                                              text: 'Save',
                                              color: kwhite,
                                              size: 17,
                                              letterspace: 0.1,
                                              weight: FontWeight.w600,
                                              family: 'Poppins'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    }),
                20.hBox,
                AppTextFeild(
                    type: TextInputType.number,
                    label: "Total Amount",
                    hinttext: "Enter Total Amount",
                    controller: totalCtrl),
                20.hBox,
                AppTextFeild(
                    type: TextInputType.number,
                    label: "Discount Amount",
                    hinttext: "Enter Discount Amount",
                    controller: discCtrl),
                20.hBox,
                AppTextFeild(
                    type: TextInputType.number,
                    label: "Advance Amount ",
                    hinttext: "Enter Advance Amount",
                    controller: advanCtrl),
                20.hBox,
                AppTextFeild(
                    type: TextInputType.number,
                    label: "Balance Amount",
                    hinttext: "Enter Balence Amount",
                    controller: balanCtrl),
                20.hBox,
                AppTextFeild(
                    label: "Treatment Date",
                    hinttext: "Select Date",
                    suffix: SvgPicture.asset(
                      'assets/images/uil_calender.svg',
                    ),
                    controller: nameCtrl),
                20.hBox,
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AppButton(
                onPressed: () async {
                  final Uri uri = Uri.parse('$baseUrl$loginUrl');
                  var response = await http.post(
                    uri,
                    headers: {
                      'Authorization':
                          'Bearer ${logintoken}',
                    },
                    body: """{
                        "name":${nameCtrl.text},
                        "excecutive":"",
                        "payment":"",
                        "phone:${whatsCtrl.text},
                        "address":${addCtrl.text},
                        "total_amount":${totalCtrl.text},
                        "dicount_amount":${discCtrl.text},
                        "advance_amount":${advanCtrl.text},
                        "balance_amount":${balanCtrl.text},
                        "date_nd_time:"",
                        "id":"",
                        "male":"5",
                        "female":"4",
                        "branch":${branchCtrl.text},
                        "treatment":"100"

                    }""",
                  );
                  log(response.body);
                  if (response.statusCode == 200) {
                    var data = jsonDecode(response.body);
                  } else {}
                },
                child: AppText(
                    text: 'Save',
                    color: kwhite,
                    size: 17,
                    letterspace: 0.1,
                    weight: FontWeight.w600,
                    family: 'Poppins'),
              ),
            )),
      );
    }
  }

  getbranchlist() async {
    log("$baseUrl$branchListUrl");
    final response =
        await http.get(Uri.parse("$baseUrl$branchListUrl"), headers: {
      'Authorization': 'Bearer $logintoken',
    });
    log(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return BranchList.fromJson(json);
    } else {}
  }

  gettreatlist() async {
    log("$baseUrl$treatmentListUrl");
    final response =
        await http.get(Uri.parse("$baseUrl$treatmentListUrl"), headers: {
      'Authorization': 'Bearer $logintoken',
    });
    log(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return TreatmentList.fromJson(json);
    } else {}
  }

  adddata() {}
}
