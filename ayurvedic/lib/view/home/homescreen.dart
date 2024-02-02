import 'dart:convert';
import 'dart:developer';
import 'package:ayurvedic/controller/service/url.dart';
import 'package:ayurvedic/model/patientlistmodel.dart';
import 'package:ayurvedic/utils/helper/helper_screensize.dart';
import 'package:ayurvedic/utils/string.dart';
import 'package:http/http.dart' as http;
import 'package:ayurvedic/utils/colors.dart';
import 'package:ayurvedic/utils/extensions/space_ext.dart';
import 'package:ayurvedic/view/components/appbutton.dart';
import 'package:ayurvedic/view/components/apptext.dart';
import 'package:ayurvedic/view/components/apptextfeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../pages/auth/registerscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchCtrl = TextEditingController();
  PatientList? patientlist;
  bool isLoading = true;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    patientlist = await getpatientlist();
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
        child: Center(
          child: CircularProgressIndicator(
            color: ktextgreen,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(0, 242),
            child: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    'assets/images/bell.svg',
                  ),
                )
              ],
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: kblack.withOpacity(0.2)))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      100.hBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 2,
                              child: AppTextFeild(
                                controller: searchCtrl,
                                hinttext: 'Search for treatment',
                                height: 50,
                                prefix: SvgPicture.asset(
                                    'assets/images/searchic.svg'),
                              )),
                          5.wBox,
                          Expanded(
                              child: AppButton(
                            onPressed: () {},
                            child: AppText(
                              text: 'Search',
                              color: kwhite,
                              size: 12,
                              letterspace: 0.1,
                              weight: FontWeight.w500,
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: 'Sort by :',
                            size: 16,
                            color: kloginhead,
                            weight: FontWeight.w500,
                          ),
                          SizedBox(
                              width: 169,
                              child: OutlinedButton(
                                  onPressed: () {}, child: const Text("data"))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
        body: ListView.builder(
          itemCount: patientlist?.patient?.length,
          itemBuilder: (context, index) {
            Patient? data = patientlist?.patient![index];
            if (patientlist?.patient?.length == 0) {
              return Center(
                child: AppText(text: 'Data Not Found'),
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: kcontainercolor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            AppText(
                              text: "${data?.id ?? ''}. ",
                              color: kblack,
                              weight: FontWeight.w500,
                              size: 18,
                            ),
                            Expanded(
                              flex: 2,
                              child: AppText(
                                  text: data?.name ?? '',
                                  color: kblack,
                                  weight: FontWeight.w500,
                                  size: 18,
                                  family: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45.0, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Couple Combo Package (Rejuven...",
                              color: ktextgreen,
                              size: 16,
                              weight: FontWeight.w300,
                            ),
                            10.hBox,
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/uil_calender.svg'),
                                3.wBox,
                                AppText(
                                    text: data!.dateNdTime.toString(),
                                    color: kblack.withOpacity(0.5),
                                    size: 15,
                                    weight: FontWeight.w400,
                                    family: 'Poppins'),
                                20.wBox,
                                SvgPicture.asset('assets/images/person.svg'),
                                3.wBox,
                                AppText(
                                    text: data.user ?? '',
                                    color: kblack.withOpacity(0.5),
                                    size: 15,
                                    weight: FontWeight.w400,
                                    family: 'Poppins'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: kblack.withOpacity(0.2),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AppText(
                                text: 'View Booking details',
                                color: kblack,
                                size: 16,
                                weight: FontWeight.w300,
                                family: 'Poppins'),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: ktextgreen,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
        bottomNavigationBar: SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AppButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ));
                },
                child: AppText(
                    text: 'Register Now',
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

  getpatientlist() async {
    log("$baseUrl$patientListUrl");
    final response =
        await http.get(Uri.parse("$baseUrl$patientListUrl"), headers: {
      'Authorization': 'Bearer $logintoken',
    });
    log(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return PatientList.fromJson(json);
    } else {}
  }
}
