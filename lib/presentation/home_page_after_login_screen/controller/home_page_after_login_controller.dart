// import '/core/app_export.dart';
// import 'package:vote_test/presentation/home_page_after_login_screen/models/home_page_after_login_model.dart';
//
// class HomePageAfterLoginController extends GetxController {
//   Rx<HomePageAfterLoginModel> homePageAfterLoginModelObj =
//       HomePageAfterLoginModel().obs;
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//
//   onSelected(dynamic value) {
//     selectedDropDownValue = value as SelectionPopupModel;
//     homePageAfterLoginModelObj.value.dropdownItemList.forEach((element) {
//       element.isSelected = false;
//       if (element.id == value.id) {
//         element.isSelected = true;
//       }
//     });
//     homePageAfterLoginModelObj.value.dropdownItemList.refresh();
//   }
//
//   onSelected1(dynamic value) {
//     selectedDropDownValue1 = value as SelectionPopupModel;
//     homePageAfterLoginModelObj.value.dropdownItemList1.forEach((element) {
//       element.isSelected = false;
//       if (element.id == value.id) {
//         element.isSelected = true;
//       }
//     });
//     homePageAfterLoginModelObj.value.dropdownItemList1.refresh();
//   }
// }
