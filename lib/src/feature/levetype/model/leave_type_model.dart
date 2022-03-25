class LeaveTypeModel{
final String id;
  final String name;
  final String? note;
  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
        id: json["id"].toString(), name: json["leave_type"],note: json["notes"]);
  }

  LeaveTypeModel({required this.id, required this.name,required this.note});
}
