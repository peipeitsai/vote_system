import 'package:vote_test/presentation/app_key_screen/app_key_screen.dart';
import 'package:vote_test/presentation/home_screen/home_screen.dart';

import 'controller/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import '../revote_success_screen/revote_success_screen.dart';
import '../vote_success_screen/vote_success_screen.dart';

class MenuScreen extends StatefulWidget {

  final connector,session, uri,flag;
  var number = 0;
  MenuScreen({Key? key,
    required this.connector,
    required this.session,
    required this.uri,
    required this.flag})
      :super(key: key);

  State<MenuScreen> createState() =>
      _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>{


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray500,
            body: Container(
                width: size.width,
                child: SingleChildScrollView(
                    child: Container(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {
                                onTapImgClose();
                              },
                              child: Padding(
                                  padding:
                                      getPadding(left: 32, top: 30, right: 32),
                                  child: CommonImageView(
                                      svgPath: ImageConstant.imgClose,
                                      height: getVerticalSize(37.00),
                                      width: getHorizontalSize(38.00))))),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding:
                                  getPadding(left: 144, top: 209, right: 144),
                              child: CommonImageView(
                                  imagePath: ImageConstant.imgVotelogo,
                                  height: getVerticalSize(50.00),
                                  width: getHorizontalSize(80.00)))),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: getPadding(left: 32, top: 43, right: 32),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CommonImageView(
                                        svgPath: ImageConstant.imgHome,
                                        height: getVerticalSize(26.00),
                                        width: getHorizontalSize(29.00)),
                                    GestureDetector(
                                        onTap: () {
                                          onTapHome();
                                        },
                                        child: Padding(
                                            padding:
                                                getPadding(left: 16, bottom: 1),
                                            child: Text("lbl10".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtMulishRegular24
                                                    .copyWith())))
                                  ]))),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: getPadding(left: 32, top: 44, right: 32),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CommonImageView(
                                        svgPath: ImageConstant.imgPlus,
                                        height: getVerticalSize(26.00),
                                        width: getHorizontalSize(27.00)),
                                    GestureDetector(
                                        onTap: () {
                                          onTapIdentityAuthentication();
                                        },
                                        child: Padding(
                                            padding:
                                                getPadding(left: 17, bottom: 2),
                                            child: Text("lbl6".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtMulishRegular24
                                                    .copyWith()))
                                    )
                                  ]))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(left: 32, top: 44, right: 32),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CommonImageView(
                                                svgPath: ImageConstant.imgPlus,
                                                height: getVerticalSize(26.00),
                                                width: getHorizontalSize(27.00)),
                                            GestureDetector(
                                                onTap: () {
                                                  onTapKey();
                                                },
                                                child: Padding(
                                                    padding:
                                                    getPadding(left: 17, bottom: 2),
                                                    child: Text("驗證金鑰".tr,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.left,
                                                        style: AppStyle
                                                            .txtMulishRegular24
                                                            .copyWith()))
                                            )
                                          ]))),

                    ]))))));
  }

  onTapImgClose() {
    Get.back();
  }

  onTapHome() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>HomeScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag,votefor: widget.number)));
  }

  onTapIdentityAuthentication() {
   Get.toNamed(AppRoutes.identityAuthenticationScreen);
    //Get.toNamed(AppRoutes.connectMetamaskScreen);
  }
  onTapKey(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>AppKeyScreen(connector: widget.connector, session: widget.session, uri: widget.uri,flag:widget.flag)));
  }

}
