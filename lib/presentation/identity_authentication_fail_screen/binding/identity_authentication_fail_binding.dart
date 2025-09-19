import '../controller/identity_authentication_fail_controller.dart';
import 'package:get/get.dart';

class IdentityAuthenticationFailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IdentityAuthenticationFailController());
  }
}
