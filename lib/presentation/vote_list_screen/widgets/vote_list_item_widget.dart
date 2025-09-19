import '../controller/vote_list_controller.dart';
import '../models/vote_list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';
import 'package:vote_test/widgets/custom_button.dart';
import  '../models/vote_list_model.dart';
// ignore: must_be_immutable
class VoteListItemWidget extends StatelessWidget {
  VoteListItemWidget(this.voteListItemModelObj, {this.onTapBtntf});

  VoteListItemModel voteListItemModelObj;

  Rx<VoteListModel> voteListModelObj = VoteListModel().obs;
  var controller = Get.find<VoteListController>();

  VoidCallback? onTapBtntf;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(
        left: 2,
        top: 16.0,
        bottom: 16.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: AppDecoration.outlineBlack9003f.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder30,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: getMargin(
                    left: 12,
                    top: 17,
                    bottom: 13,
                  ),
                  padding: getPadding(
                    left: 8,
                    top: 1,
                    right: 8,
                    bottom: 1,
                  ),
                  decoration: AppDecoration.txtFillGray500.copyWith(
                    borderRadius: BorderRadiusStyle.txtCircleBorder15,
                  ),
                  child: Text(
                    voteListItemModelObj.id,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppStyle.txtRobotoRomanBlack24WhiteA700.copyWith(),
                  ),
                ),
                Container(
                  height: getVerticalSize(
                    42.00,
                  ),
                  width: getHorizontalSize(
                    140.00,
                  ),
                  margin: getMargin(
                    top: 11,
                    right: 27,
                    bottom: 7,
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: getMargin(
                            left: 10,
                            top: 8,
                            bottom: 10,
                          ),
                          decoration: AppDecoration.txtOutlineBlack9003f,
                          child: Text(
                            voteListItemModelObj.name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppStyle.txtRobotoRomanBlack18.copyWith(),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: getPadding(
                            right: 10,
                          ),
                          child: CommonImageView(
                            imagePath: ImageConstant.imgCandidatepic,
                            height: getVerticalSize(
                              42.00,
                            ),
                            width: getHorizontalSize(
                              79.00,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomButton(
            width: 74,
            text: "lbl3".tr,
            margin: getMargin(
              left: 17,
              top: 6,
              bottom: 8,
            ),
            shape: ButtonShape.CircleBorder23,
            padding: ButtonPadding.PaddingAll8,
            onTap: onTapBtntf,
          ),
        ],
      ),
    );
  }
}
