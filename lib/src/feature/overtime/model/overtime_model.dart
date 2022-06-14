class OvertimeModel{
  final String id;
  final String name;
  final String date;
  factory OvertimeModel.fromJson(Map<String,dynamic>json){
    return OvertimeModel(id: json["id"].toString(), name: json["name"], date: json["date"]);
  }
  OvertimeModel({
    required this.id,
    required this.name,
    required this.date
  });
}