import '/core/app_export.dart';
import 'package:vote_test/presentation/connect_metamask_screen/models/connect_metamask_model.dart';

class connectMetamaskController extends GetxController {
  Rx<connectMetamaskModel> connectMetamaskModelObj =
      connectMetamaskModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
