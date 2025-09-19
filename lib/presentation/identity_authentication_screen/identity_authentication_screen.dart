import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import 'package:vote_test/widgets/custom_text_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';


class IdentityAuthenticationScreen
    extends GetWidget{

  TextEditingController iden = TextEditingController();
  TextEditingController health = TextEditingController();
  TextEditingController me = TextEditingController();
  TextEditingController ph = TextEditingController();


  Future login() async {
    Uri url =Uri.parse( "http://172.20.10.4:8088/flutter-login-signup/login.php");
    var response = await http.post(url, body: {
      "identify": iden.text,
      "healthid": health.text,
      "meta": me.text,
      "phone": ph.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      // print("ooo");
      Fluttertoast.showToast(
          msg: "Authentication Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
      onTapBtntf();
    } else {
      // print("sss");
      Fluttertoast.showToast(
          msg: "Authentication Failed!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 16.0
      );
      onTapBtntg();
    }
  }


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
                              alignment: Alignment.center,
                              child: Container(
                                  margin: getMargin(
                                      left: 30, top: 40, right: 16, bottom: 20),
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
                                        CustomTextFormField(
                                            width: 319,
                                            focusNode: FocusNode(),
                                            controller:
                                            iden,
                                            hintText: '身分證ID',
                                            margin:
                                            getMargin(top: 54, right: 10),
                                            alignment: Alignment.centerLeft),
                                        CustomTextFormField(
                                            width: 319,
                                            focusNode: FocusNode(),
                                            controller: health,
                                            hintText: '健保卡卡號',
                                            margin:
                                            getMargin(top: 22, right: 10),
                                            alignment: Alignment.centerLeft),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    top: 22, right: 10),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      CustomTextFormField(
                                                          width: 319,
                                                          focusNode:
                                                          FocusNode(),
                                                          controller: ph,
                                                          hintText: '手機號碼'),

                                                    ]))),
                                        CustomTextFormField(
                                            width: 319,
                                            focusNode: FocusNode(),
                                            controller: me,
                                            hintText: '錢包地址',
                                            margin:
                                            getMargin(top: 22, right: 10),
                                            textInputAction:
                                            TextInputAction.done,
                                            alignment: Alignment.centerLeft),
                                        CustomButton(
                                            width: 319,
                                            text: "lbl6".tr,
                                            margin:
                                            getMargin(top: 74, right: 10),
                                            onTap: (){
                                              login();
                                            },
                                            alignment: Alignment.centerLeft)
                                      ])))
                        ]))))));
  }

  onTapImgMenu() {
    Get.toNamed(AppRoutes.menuScreen);
  }

  onTapBtntf() {
    //Get.toNamed(AppRoutes.phoneAuthScreen);
    Get.toNamed(AppRoutes.connectMetamaskScreen);
  }
  onTapBtntg() {
    Get.toNamed(AppRoutes.identityAuthenticationFailScreen);
  }

}
