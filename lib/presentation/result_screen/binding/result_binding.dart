import '../controller/result_controller.dart';
import 'package:get/get.dart';

class ResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultController());
  }
}
