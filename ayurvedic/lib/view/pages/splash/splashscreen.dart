// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:ayurvedic/utils/string.dart';
import 'package:ayurvedic/view/home/homescreen.dart';
import 'package:ayurvedic/view/pages/auth/loginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async{
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = await pref.getString(tokenkey??'');
      if (token=='' || token==null) {
         Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) =>  LoginScreen(),
          ));
      }else{
        logintoken = token;
         Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) =>  HomePage(),
          ));
      }
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/images/splashbg.png',
                  fit: BoxFit.cover,
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/images/greenbg.png',
                  fit: BoxFit.cover,
                )),
            Center(
              child: SizedBox(
                  width: 134,
                  height: 142,
                  child: Image.asset(
                    'assets/images/logo.png',
                  )),
            )
          ],
        ),
      ),
    );
  }
}
