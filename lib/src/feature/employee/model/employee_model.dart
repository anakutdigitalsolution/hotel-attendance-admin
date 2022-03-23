import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';

class EmployeeModel {
  final String id;
  final String name;

  final String gender;
  final String? img;
  final String? phone;
  final String? status;
  final String positionId;
  final String timetableId;
  final String storeId;
  final String? address;
  final PositionModel positionModel;
  final DepartmentModel departmentModel;
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
      address: json["address"],
      status: json["status"],
      positionId: json["position_id"].toString(),
      timetableId: json["timetable_id"].toString(),
      storeId: json["store_id"].toString(),
      positionModel: PositionModel.fromJson(json["position"]),
      departmentModel: DepartmentModel.fromJson(json["department"]),
      // timetableList: time
    );
  }
  EmployeeModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.address,
    required this.img,
    required this.phone,
    required this.status,
    required this.positionId,
    required this.timetableId,
    required this.storeId,
    required this.positionModel,
    required this.departmentModel,
    // required this.timetableList
  });
}
