import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/role_model.dart';

import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';

class EmployeeModel {
  final String id;
  final String name;
  final String gender;
  final String? img;
  final String? phone;
  final String? positionId;
  final String? address;
  final String? checkinStatus;
  final String? checkinId;
  final String? username;
  final String? nationalilty;
  final String? dob;
  final String? email;
  final String? officeTel;
  final String? no;
  final String? card;

  final String? type;

  final PositionModel? positionModel;
  final DepartmentModel? departmentModel;
  final RoleModel? roleModel;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json["id"].toString(),
      name: json["name"],
      gender: json["gender"],
      img: json["profile_url"],
      phone: json["employee_phone"],
      username: json["username"],
      address: json["address"],
      nationalilty: json["nationality"],
      dob: json["dob"],
      card: json["card_number"],
      officeTel: json["office_tel"],
      no: json["no"],
      email: json["email"],
      type: json["em_type"].toString(),
      positionId: json["position_id"].toString(),
      checkinStatus: json["checkin_status"],
      checkinId: json["checkin_id"].toString(),
      roleModel: json["role"] == null ? null : RoleModel.fromJson(json["role"]),
      positionModel: json["position"] == null
          ? null
          : PositionModel.fromJson(json["position"]),
      departmentModel: json["department"] == null
          ? null
          : DepartmentModel.fromJson(json["department"]),
    );
  }
  EmployeeModel(
      {required this.id,
      required this.name,
      required this.gender,
      required this.address,
      required this.img,
      required this.phone,
      required this.positionId,
      required this.username,
      required this.nationalilty,
      required this.dob,
      required this.email,
      required this.no,
      required this.card,
      required this.officeTel,
      required this.type,
      required this.positionModel,
      required this.departmentModel,
      required this.checkinStatus,
      required this.roleModel,
      required this.checkinId});
}
