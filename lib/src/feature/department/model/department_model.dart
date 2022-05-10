
import 'package:hotle_attendnce_admin/src/feature/group/model/group_model.dart';
import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';

class DepartmentModel {
  final String id;
  final String? name;
  final String? groupId;
  final String? locationId;
  final String? notes;
  final LocationModel? locationModel;
  final GroupModel? groupModel;
  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
        id: json["id"].toString(),
        name: json["department_name"],
        notes: json["notes"],
        groupId: json["group_department_id"].toString(),
        groupModel:
            json["group"] == null ? null : GroupModel.fromJson(json["group"]),
        locationModel: json["location"] == null
            ? null
            : LocationModel.fromJson(json["location"]),
        locationId: json["location_id"].toString());
  }

  DepartmentModel(
      {required this.id,
      required this.name,
      required this.groupId,
      required this.notes,
      required this.locationId,
      required this.groupModel,
      required this.locationModel});
}
