import '/core/app_export.dart';
import 'package:vote_test/presentation/result_screen/models/result_item_model.dart';
import 'package:vote_test/presentation/result_screen/models/result_model.dart';

class ResultController extends GetxController {
  Rx<ResultModel> resultModelObj = ResultModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
