import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/model/leave_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';

class EmployeeModel {
  final String id;
  final String name;
  final String gender;
  final String? img;
  final String? phone;
  final String? status;
  final String? positionId;
  // final String timetableId;
  final String? storeId;
  final String? address;
  final String? checkinStatus;
  final String? leaveStatus;
  final String? checkinId;
  final String? username;
  // final LeaveModel? leaveModel;
  final PositionModel? positionModel;
  final DepartmentModel? departmentModel;
  // final List<TimetableModel> timetableList;
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    // List<TimetableModel> time = [];
    // json["timetable"].forEach((val) {
    //   time.add(TimetableModel.fromJson(val));
    // });
    return EmployeeModel(
      id: json["id"].toString(),
      name: json["name"],
      gender: json["gender"],
      img: json["profile_url"],
      phone: json["employee_phone"],
      username: json["username"],
      address: json["address"],
      status: json["status"],
      positionId: json["position_id"].toString(),
      // timetableId: json["timetable_id"].toString(),
      storeId: json["store_id"].toString(),
      checkinStatus: json["checkin_status"],
      leaveStatus: json["leave_status"],
      checkinId: json["checkin_id"].toString(),
      // leaveModel:
      //     json["leave"] == null ? null : LeaveModel.fromJson(json["leave"]),
      positionModel: json["position"] == null
          ? null
          : PositionModel.fromJson(json["position"]),
      departmentModel: json["department"] == null
          ? null
          : DepartmentModel.fromJson(json["department"]),

      // timetableList: time
    );
  }
  EmployeeModel(
      {required this.id,
      required this.name,
      required this.gender,
      required this.address,
      required this.img,
      required this.phone,
      required this.status,
      required this.positionId,
      // required this.timetableId,
      required this.username,
      required this.storeId,
      required this.positionModel,
      required this.departmentModel,
      // required this.leaveModel,
      required this.checkinStatus,
      required this.leaveStatus,
      required this.checkinId});
}
