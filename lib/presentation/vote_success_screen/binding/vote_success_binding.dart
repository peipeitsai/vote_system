import '../controller/vote_success_controller.dart';
import 'package:get/get.dart';

class VoteSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VoteSuccessController());
  }
}
