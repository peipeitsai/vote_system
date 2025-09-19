import '../controller/identity_authentication_success_controller.dart';
import 'package:get/get.dart';

class IdentityAuthenticationSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IdentityAuthenticationSuccessController());
  }
}
