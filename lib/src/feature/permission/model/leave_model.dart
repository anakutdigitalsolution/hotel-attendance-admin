import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/model/leave_type_model.dart';


class LeaveModel {
  final String id;
  final String date;
  final String status;
  final String fromDate;
  final String toDate;
  final String reason;
  final String number;
  final EmployeeModel? employeeModel;
  final LeaveTypeModel? leaveTypeModel;
  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
        id: json["id"].toString(),
        date: json["date"],
        status: json["status"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        number: json["number"],
        reason: json["reason"],
        employeeModel: EmployeeModel.fromJson(json["employee"]),
        leaveTypeModel: LeaveTypeModel.fromJson(json["leavetype"]));
  }
  LeaveModel(
      {required this.id,
      required this.date,
      required this.status,
      required this.fromDate,
      required this.toDate,
      required this.number,
      required this.reason,
      required this.employeeModel,
      required this.leaveTypeModel});
}
