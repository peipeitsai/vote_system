import '../controller/circular_screen_controller.dart';
import 'package:get/get.dart';

class CircularScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CircularScreenController());
  }
}