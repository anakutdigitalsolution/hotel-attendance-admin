class DepartmentModel {
  final String id;
  final String name;
  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
        id: json["id"].toString(), name: json["department_name"]);
  }

  DepartmentModel({required this.id, required this.name});
}
