class LeaveTypeModel {
  final String id;
  final String leaveType;
  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
        id: json['id'].toString(), leaveType: json['leave_type']);
  }
  LeaveTypeModel({required this.id, required this.leaveType});
}

