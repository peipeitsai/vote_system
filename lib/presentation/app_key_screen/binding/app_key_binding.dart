import '../controller/app_key_controller.dart';
import 'package:get/get.dart';

class AppKeyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppKeyController());
  }
}