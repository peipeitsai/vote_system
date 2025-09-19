import 'controller/identity_authentication_success_controller.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';

class IdentityAuthenticationSuccessScreen
    extends GetWidget<IdentityAuthenticationSuccessController> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray300,
            body: Container(
                width: size.width,
                child: SingleChildScrollView(
                    child: Container(
                        height: size.height,
                        width: size.width,
                        child: Stack(children: [
                          Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  width: getHorizontalSize(336.00),
                                  margin: getMargin(
                                      left: 16, top: 20, right: 16, bottom: 20),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                                padding: getPadding(left: 10),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      CommonImageView(
                                                          imagePath:
                                                          ImageConstant
                                                              .imgVotelogo,
                                                          height:
                                                          getVerticalSize(
                                                              50.00),
                                                          width:
                                                          getHorizontalSize(
                                                              80.00)),
                                                      GestureDetector(
                                                          onTap: () {
                                                            onTapImgMenu();
                                                          },
                                                          child: Padding(
                                                              padding:
                                                              getPadding(
                                                                  left: 86),
                                                              child: CommonImageView(
                                                                  svgPath:
                                                                  ImageConstant
                                                                      .imgMenu,
                                                                  height:
                                                                  getSize(
                                                                      50.00),
                                                                  width: getSize(
                                                                      50.00))))
                                                    ]))),
                                        Center(
                                            child: Padding(
                                                padding: getPadding(top: 60),
                                                child:Text("身分驗證",
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: AppStyle
                                                        .txtRobotoRomanBlack24
                                                        .copyWith()))),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    left: 118,
                                                    top: 98,
                                                    right: 118),
                                                child: CommonImageView(
                                                    svgPath:
                                                    ImageConstant.imgMobile,
                                                    height: getSize(83.00),
                                                    width: getSize(83.00)))),
                                        Center(
                                            child: Padding(
                                                padding: getPadding(top: 60),
                                                child:Text("驗證成功",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: AppStyle
                                                        .txtRobotoRomanBlack36
                                                        .copyWith()))),
                                        CustomButton(
                                            width: 319,
                                            text: "連接Metamask".tr,
                                            margin:
                                            getMargin(top: 127, right: 10),
                                            onTap: onTapBtntf,
                                            alignment: Alignment.centerLeft)
                                      ])))
                        ]))))));
  }

  onTapImgMenu() {
    Get.toNamed(AppRoutes.menuScreen);
  }

  onTapBtntf() {
    Get.toNamed(AppRoutes.connectMetamaskScreen);
  }
}