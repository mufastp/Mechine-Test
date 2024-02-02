// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:ayurvedic/controller/service/url.dart';
import 'package:ayurvedic/model/logindatamodel.dart';
import 'package:ayurvedic/utils/extensions/space_ext.dart';
import 'package:ayurvedic/utils/helper/helper_screensize.dart';
import 'package:ayurvedic/utils/string.dart';
import 'package:ayurvedic/view/home/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/colors.dart';
import '../../components/appbutton.dart';
import '../../components/apptext.dart';
import '../../components/apptextfeild.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailCtrl = TextEditingController(),
      passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: SizedBox(
        width: ScreenUtil.screenWidth,
        height: ScreenUtil.screenHeight,
        child: Column(
          children: [
            SizedBox(
              width: ScreenUtil.screenWidth,
              height: 217,
              child: Stack(
                children: [
                  SizedBox(
                    width: ScreenUtil.screenWidth,
                    child: Image.asset('assets/images/bg2.png',fit: BoxFit.cover,)),
                  Center(
                      child: SizedBox(
                          width: 80,
                          height: 84,
                          child: Image.asset(
                            'assets/images/logo.png',
                          ))),
                ],
              ),
            ),
            10.hBox,
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: 'Login Or Register To Book Your Appointments',
                        size: 24,
                        weight: FontWeight.w600,
                        color: kloginhead,
                      ),
                      Column(
                        children: [
                          AppTextFeild(
                            type: TextInputType.emailAddress,
                            controller: emailCtrl,
                            label: 'Email',
                            hinttext: 'Enter your email',
                          ),
                          20.hBox,
                          AppTextFeild(
                            isobsecure: true,
                            controller: passCtrl,
                            label: 'Password',
                            hinttext: 'Enter Password',
                          ),
                          30.hBox,
                          AppButton(
                            onPressed: () {
                             if (emailCtrl.text =='') {
                               log("hiiii");
                             }else if(passCtrl.text==''){
                              log("hiiii2");
                             }else{
                              log("hiiii3");
                              LoginPost body =LoginPost();
                              body.username = emailCtrl.text.trim();
                              body.password = passCtrl.text.trim();
                              loginnow(body, context);
                             }
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          AppText(
                            text:
                                'By creating or logging into an account you are agreeing ',
                            size: 12,
                            weight: FontWeight.w300,
                            color: kblack,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                text: 'with our ',
                                size: 12,
                                weight: FontWeight.w300,
                                color: kblack,
                              ),
                              AppText(
                                text: 'Terms and Conditions ',
                                size: 12,
                                weight: FontWeight.w500,
                                color: kblue,
                              ),
                              AppText(
                                text: 'and ',
                                size: 12,
                                weight: FontWeight.w300,
                                color: kblack,
                              ),
                              AppText(
                                text: ' Privacy Policy ',
                                size: 12,
                                weight: FontWeight.w500,
                                color: kblue,
                              ),
                              AppText(
                                text: '.',
                                size: 12,
                                weight: FontWeight.w300,
                                color: kblack,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  loginnow(LoginPost body,BuildContext context) async {
     SharedPreferences pref = await SharedPreferences.getInstance();
    log('$baseUrl$loginUrl');
    log(body.toString());
    final map = <String, dynamic>{};
    map['username'] = body.username;
    map['password'] = body.password;

    final Uri uri = Uri.parse('$baseUrl$loginUrl');
    var response = await http.post(
      uri,
      body: map,
    );
     log(response.body);
    if (response.statusCode==200) {
      var data = jsonDecode(response.body);
      logindata =  LoginData.fromJson(data);
      userdata  = logindata?.userDetails;
      if (logindata?.status==true) {
        pref.setString(tokenkey!,logindata!.token.toString() );
        // ignore: prefer_const_constructors
        Navigator.push(context, CupertinoPageRoute(builder: (context) => HomePage(),));

      }
    } else {
     
    }
  }
}
