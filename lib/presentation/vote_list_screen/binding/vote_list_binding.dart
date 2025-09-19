import '../controller/vote_list_controller.dart';
import 'package:get/get.dart';

class VoteListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VoteListController());
  }
}
