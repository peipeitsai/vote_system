import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vote_test/presentation/home_screen/binding/home_binding.dart';
import 'package:vote_test/presentation/home_screen/controller/home_controller.dart';
import 'package:vote_test/presentation/home_screen/home_screen.dart';
import 'package:vote_test/presentation/home_screen/models/home_model.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/common_image_view.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key,})
      :super(key: key);

  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  get tokenService => null;

  @override
  void initState1(){
    FirebaseMessaging.instance.getToken().then((newToken){
      print("FCM token:");
      print(newToken);
      tokenService.updateTokenOnServer(newToken);

    });
  }
  void initState(){
    Timer(const Duration(seconds : 3),() {
      Get.toNamed(AppRoutes.homeScreen);
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context){
    return Container(
      child: Scaffold(
      backgroundColor: ColorConstant.gray300,
      body: Container(
      child: Center(
            child: Padding(
                padding: getPadding(
                    left: 102,
                    top: 80,
                    right: 102),
                child: CommonImageView(
                    imagePath: ImageConstant
                        .ballot,
                    height: getSize(100.00),
                    width: getSize(100.00))),),)
      ),
    );
  }
}