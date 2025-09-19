import '../controller/app_key_success_controller.dart';
import 'package:get/get.dart';

class AppKeySuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppKeySuccessController());
  }
}