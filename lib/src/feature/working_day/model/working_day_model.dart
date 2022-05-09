class WorkingDayModel{
   final String id;
   final String? name;
  final String? workingDay;
  final String? offDay;
  final String? notes;
  factory WorkingDayModel.fromJson(Map<String, dynamic> json) {
    return WorkingDayModel(
        id: json["id"].toString(),
        name: json["name"],
        workingDay: json["working_day"],
        notes: json["notes"],
        offDay: json["off_day"],
        );
  }

  WorkingDayModel(
      {required this.id,
      required this.name,
      required this.workingDay,
      required this.offDay,
      required this.notes,
      });
}