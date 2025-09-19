import '../controller/identity_authentication_controller.dart';
import 'package:get/get.dart';

class IdentityAuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IdentityAuthenticationController());
  }
}
