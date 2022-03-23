import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';

class EmployeeTimetablModel {
  final EmployeeModel employeeModel;
  final List<TimetableModel> timetableList;
  factory EmployeeTimetablModel.fromJson(Map<String, dynamic> json) {
    List<TimetableModel> time = [];
    json["timetable"].forEach((val) {
      time.add(TimetableModel.fromJson(val));
    });
    return EmployeeTimetablModel(
        employeeModel: EmployeeModel.fromJson(json), timetableList: time);
  }

  EmployeeTimetablModel(
      {required this.employeeModel, required this.timetableList});
}
