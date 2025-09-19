import 'package:get/get.dart';
import 'package:vote_test/data/models/selectionPopupModel/selection_popup_model.dart';

class HomePageAfterLoginModel {
  RxList<SelectionPopupModel> dropdownItemList = [
    SelectionPopupModel(
      id: 1,
      title: "第7屆市議員選舉",
      isSelected: true,
    ),
    SelectionPopupModel(
      id: 2,
      title: "第7屆市長選舉",
    ),
    SelectionPopupModel(
      id: 3,
      title: "第7屆總統副總統選舉",
    )
  ].obs;

  RxList<SelectionPopupModel> dropdownItemList1 = [
    SelectionPopupModel(
      id: 1,
      title: "第6屆市議員選舉",
      isSelected: true,
    ),
    SelectionPopupModel(
      id: 2,
      title: " 第6屆市長選舉",
    ),
    SelectionPopupModel(
      id: 3,
      title: "第6屆總統副總統選舉",
    )
  ].obs;
}