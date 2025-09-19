import '../controller/activity_check_candi_controller.dart';
import 'package:get/get.dart';

class ActivityCheckCandiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityCheckCandiController());
  }
}
