import '../controller/result_controller.dart';
import '../models/result_item_model.dart';
import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';

// ignore: must_be_immutable
class ResultItemWidget extends StatelessWidget {
  ResultItemWidget(this.resultItemModelObj);

  ResultItemModel resultItemModelObj;

  var controller = Get.find<ResultController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: getPadding(
          top: 15.5,
          bottom: 15.5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: getSize(
                15.00,
              ),
              width: getSize(
                15.00,
              ),
              margin: getMargin(
                top: 5,
                bottom: 22,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.red400,
                borderRadius: BorderRadius.circular(
                  getHorizontalSize(
                    7.50,
                  ),
                ),
              ),
            ),
            Padding(
              padding: getPadding(
                left: 9,
                bottom: 25,
              ),
              child: Text(
                resultItemModelObj.name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtInterRegular20.copyWith(),
              ),
            ),
            Padding(
              padding: getPadding(
                right: 5,
                top: 25,
              ),
              child: Text(
                resultItemModelObj.vote_sum,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: AppStyle.txtInterRegular20.copyWith(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
