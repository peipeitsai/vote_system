// import 'package:flutter/material.dart';
// import 'controller/home_page_after_login_controller.dart';
// import 'package:vote_test/core/app_export.dart';
// import 'package:vote_test/widgets/custom_drop_down.dart';
//
//
// class HomePageAfterLoginScreen extends StatefulWidget {
//   var thisconnector, session, uri;
//   HomePageAfterLoginScreen(
//       {Key? key,
//         required this.thisconnector,
//         required this.session,
//         })
//       : super(key: key);
//
//   State<HomePageAfterLoginScreen> createState() => _HomePageAfterLoginScreenState(thisconnector:thisconnector,
//       session:session);
// }
//
// class _HomePageAfterLoginScreenState extends State<HomePageAfterLoginScreen> {
//   int _currentIndex = 0;
//   var thisconnector, session, uri;
//   _HomePageAfterLoginScreenState(
//       {required this.thisconnector,
//         required this.session,
//        });
//   @override
//   Widget build(BuildContext context) {
//
//
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: ColorConstant.gray300,
//             body: Container(
//                 width: size.width,
//                 child: SingleChildScrollView(
//                     child: Container(
//                         height: size.height,
//                         width: size.width,
//                         child: Stack(children: [
//                           Align(
//                               alignment: Alignment.topLeft,
//                               child: Container(
//                                   margin: getMargin(top: 63, bottom: 20),
//                                   child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       children: [
//                                         Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Padding(
//                                                 padding: getPadding(
//                                                     left: 16, right: 16),
//                                                 child: Row(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment.end,
//                                                     crossAxisAlignment:
//                                                     CrossAxisAlignment
//                                                         .center,
//                                                     mainAxisSize:
//                                                     MainAxisSize.max,
//                                                     children: [
//                                                       CommonImageView(
//                                                           imagePath:
//                                                           ImageConstant
//                                                               .imgVotelogo,
//                                                           height:
//                                                           getVerticalSize(
//                                                               50.00),
//                                                           width:
//                                                           getHorizontalSize(
//                                                               80.00)),
//                                                       GestureDetector(
//                                                           onTap: () {
//                                                             onTapImgMenu();
//                                                           },
//                                                           child: Padding(
//                                                               padding:
//                                                               getPadding(
//                                                                   left: 86),
//                                                               child: CommonImageView(
//                                                                   svgPath:
//                                                                   ImageConstant
//                                                                       .imgMenu,
//                                                                   height:
//                                                                   getSize(
//                                                                       50.00),
//                                                                   width: getSize(
//                                                                       50.00))))
//                                                     ]))),
//                                         Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                                 padding: getPadding(
//                                                     left: 16,
//                                                     top: 62,
//                                                     right: 16),
//                                                 child: Text("使用者".tr,
//                                                     overflow:
//                                                     TextOverflow.ellipsis,
//                                                     textAlign: TextAlign.left,
//                                                     style: AppStyle
//                                                         .txtRobotoRomanBold18
//                                                         .copyWith()))),
//
//
//                                         CustomDropDown(
//                                             width: 385,
//                                             focusNode: FocusNode(),
//                                             icon: Container(
//                                                 margin: getMargin(
//                                                     left: 30, right: 14),
//                                                 child: CommonImageView(
//                                                     svgPath: ImageConstant
//                                                         .imgPolygon1)),
//                                             hintText: "lbl18".tr,
//                                             margin: getMargin(top: 9),
//                                             alignment: Alignment.centerLeft,
//                                             items: controller.homePageAfterLoginModelObj.value
//                                                 .dropdownItemList,
//
//                                             onChanged: (value) {
//                                               controller.onSelected(value);
//                                               onChanged();
//                                             }),
//                                         CustomDropDown(
//                                             width: 385,
//                                             focusNode: FocusNode(),
//                                             icon: Container(
//                                                 margin: getMargin(
//                                                     left: 30, right: 14),
//                                                 child: CommonImageView(
//                                                     svgPath: ImageConstant
//                                                         .imgPolygon1)),
//                                             hintText: "lbl19".tr,
//                                             margin: getMargin(top: 234),
//                                             alignment: Alignment.centerLeft,
//                                             items: controller.homePageAfterLoginModelObj.value
//                                                 .dropdownItemList1,
//                                             onChanged: (value) {
//                                               controller.onSelected1(value);
//                                             })
//                                       ])))
//                         ]))))));
//   }
// }
//
// onTapImgMenu() {
//   Get.toNamed(AppRoutes.menuScreen);
// }
//
// onChanged() {
//   Get.toNamed(AppRoutes.activeInfoScreen);
// }