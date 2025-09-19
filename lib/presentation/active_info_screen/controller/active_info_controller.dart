import '/core/app_export.dart';
import 'package:vote_test/presentation/active_info_screen/models/active_info_model.dart';

class ActiveInfoController extends GetxController {
  Rx<ActiveInfoModel> activeInfoModelObj = ActiveInfoModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
