import '../controller/goto_result_controller.dart';
import 'package:get/get.dart';

class GotoResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GotoResultController());
  }
}
