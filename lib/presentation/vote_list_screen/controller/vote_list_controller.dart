import '/core/app_export.dart';
import 'package:vote_test/presentation/vote_list_screen/models/vote_list_model.dart';

class VoteListController extends GetxController {
  Rx<VoteListModel> voteListModelObj = VoteListModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
