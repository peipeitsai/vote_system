import 'package:get/get.dart';
import 'vote_list_item_model.dart';

class VoteListModel {
  RxList<VoteListItemModel> voteListItemList =[
    VoteListItemModel(
      id: "1",
      name: "哆啦a夢",
    ),
    VoteListItemModel(
      id: "2",
      name: "蠟筆小新",
    ),
    VoteListItemModel(
      id: "3",
      name: "庫洛米",
    )
  ].obs;
  //RxList.filled(5, VoteListItemModel());
}
