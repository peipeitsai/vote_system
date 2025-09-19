import '../controller/connect_metamask_controller.dart';
import 'package:get/get.dart';

class connectMetamaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => connectMetamaskController());
  }
}
