import '/core/app_export.dart';
import 'package:vote_test/presentation/app_key_screen/models/app_key_models.dart';

class AppKeyController extends GetxController {
  Rx<AppKeyModel> appKeyModelObj = AppKeyModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
