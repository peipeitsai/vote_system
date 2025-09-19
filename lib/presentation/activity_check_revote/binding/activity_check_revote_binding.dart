import '../controller/activity_check_revote_controller.dart';
import 'package:get/get.dart';

class ActivityCheckRevoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityCheckRevoteController());
  }
}
