class ResultItemModel {
//原本都空的
  String id;
  String name;
  String vote_sum;
  dynamic value;

  ResultItemModel ({
    required this.id,
    required this.name,
    required this. vote_sum,
    this.value,
  });
}
