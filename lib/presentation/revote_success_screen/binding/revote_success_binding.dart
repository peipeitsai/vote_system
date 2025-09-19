import '../controller/revote_success_controller.dart';
import 'package:get/get.dart';

class RevoteSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RevoteSuccessController());
  }
}
