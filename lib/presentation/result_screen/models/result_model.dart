import 'package:get/get.dart';
import 'result_item_model.dart';

class ResultModel {
  RxList<ResultItemModel> ResultItemList =[
    ResultItemModel(
      id: "1",
      name: "哆啦a夢",
      vote_sum:"660,000",
    ),
    ResultItemModel(
      id: "2",
      name: "蠟筆小新",
      vote_sum:"120,000",
    ),
    ResultItemModel(
      id: "3",
      name: "庫洛米",
      vote_sum:"420,000"
    )
  ].obs;
//RxList.filled(5, VoteListItemModel());
}