import '../controller/active_info_controller.dart';
import 'package:get/get.dart';

class ActiveInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActiveInfoController());
  }
}
