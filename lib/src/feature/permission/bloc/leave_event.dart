import 'package:equatable/equatable.dart';

class LeaveEvent extends Equatable {
  LeaveEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchLeaveTypeStarted extends LeaveEvent {}
class InitializeStarted extends LeaveEvent{}
class FetchLeaveStarted extends LeaveEvent{}

class RefreshLeaveStarted extends LeaveEvent{}
class AddLeaveStarted extends LeaveEvent {
  // final String employeeId;
  final String leaveTypeId;
  final String reason;
  final String number;
  final String fromDate;
  final String toDate;
  // final String date;
  AddLeaveStarted(
      {
        // required this.employeeId,
      required this.leaveTypeId,
      required this.reason,
      required this.number,
      required this.fromDate,
      required this.toDate,
      // required this.date
      });
}
class UpdateLeaveStarted extends LeaveEvent {
  final String id;
  final String leaveTypeId;
  final String reason;
  final String number;
  final String fromDate;
  final String toDate;
  // final String date;
  UpdateLeaveStarted(
      {
        required this.id,
      required this.leaveTypeId,
      required this.reason,
      required this.number,
      required this.fromDate,
      required this.toDate,
      // required this.date
      });
}
class DeleteLeaveStarted extends LeaveEvent {
  final String id;
  // final String date;
  DeleteLeaveStarted(
      {
        required this.id,
      });
}
