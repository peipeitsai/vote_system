import '/core/app_export.dart';
import 'package:vote_test/presentation/identity_authentication_screen/models/identity_authentication_model.dart';
import 'package:flutter/material.dart';

class IdentityAuthenticationController extends GetxController {
  TextEditingController idnuminputController = TextEditingController();

  TextEditingController nhinuminputController = TextEditingController();

  TextEditingController phonenuminputController = TextEditingController();

  TextEditingController messagecodeinController = TextEditingController();

  Rx<IdentityAuthenticationModel> identityAuthenticationModelObj =
      IdentityAuthenticationModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    idnuminputController.dispose();
    nhinuminputController.dispose();
    phonenuminputController.dispose();
    messagecodeinController.dispose();
  }
}
