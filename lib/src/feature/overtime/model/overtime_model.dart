import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';

class OvertimeModel {
  final String id;
  final String? userId;
  final String? reason;
  // final String? name;
  final String? date;
  final String? fromDate;
  final String? toDate;
  final String? duration;
  final String? status;
  final String? paytype;
  final String? type;
  final String? notes;
  final EmployeeModel? employeeModel;
  factory OvertimeModel.fromJson(Map<String, dynamic> json) {
    return OvertimeModel(
        id: json["id"].toString(),
        duration: json["number"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        status: json["status"],
        notes: json["notes"],
        userId: json["user_id"].toString(),
        type: json["type"],
        paytype: json["pay_type"],
        reason: json["reason"],
        employeeModel: EmployeeModel.fromJson(json["user"]),
        date: json["date"]);
  }
  OvertimeModel(
      {required this.id,
      // required this.name,
      required this.duration,
      required this.fromDate,
      required this.toDate,
      required this.status,
      required this.notes,
      required this.userId,
      required this.type,
      required this.paytype,
      required this.reason,
      required this.employeeModel,
      required this.date});
}
