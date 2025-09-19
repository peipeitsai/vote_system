import 'package:flutter/material.dart';
import 'package:vote_test/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get outlineBlack9003f => BoxDecoration(
        color: ColorConstant.gray100,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9003f,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get txtOutlineBlack9003f => BoxDecoration();
  static BoxDecoration get fillGray500 => BoxDecoration(
        color: ColorConstant.gray500,
      );
  static BoxDecoration get txtOutlineBlack9003f12 => BoxDecoration(
        color: ColorConstant.gray500,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9003f,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get fillGray300 => BoxDecoration(
        color: ColorConstant.gray300,
      );
  static BoxDecoration get fillGray100 => BoxDecoration(
        color: ColorConstant.gray100,
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get txtFillGray500 => BoxDecoration(
        color: ColorConstant.gray500,
      );
}

class BorderRadiusStyle {
  static BorderRadius txtCircleBorder15 = BorderRadius.circular(
    getHorizontalSize(
      15.00,
    ),
  );

  static BorderRadius roundedBorder31 = BorderRadius.circular(
    getHorizontalSize(
      31.50,
    ),
  );

  static BorderRadius circleBorder30 = BorderRadius.circular(
    getHorizontalSize(
      30.00,
    ),
  );
}
