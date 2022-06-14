
import 'package:equatable/equatable.dart';

class OvertimeEvent extends Equatable {
  OvertimeEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailzeOvertimeStarted extends OvertimeEvent{
   final String? dateRange;
  InitailzeOvertimeStarted({required this.dateRange});
}
class InitializeAllOvertimeStarted extends OvertimeEvent {
  final String? dateRange;
  InitializeAllOvertimeStarted({required this.dateRange});
}


class FetchOvertimeStarted extends OvertimeEvent{
   final String? dateRange;
  FetchOvertimeStarted({required this.dateRange});
}
class FetchAllOvertimeStarted extends OvertimeEvent{
   final String? dateRange;
  FetchAllOvertimeStarted({required this.dateRange});
}
class RefreshOvertimeStarted extends OvertimeEvent{
   final String? dateRange;
  RefreshOvertimeStarted({required this.dateRange});
}
class RefreshAllOvertimeStarted extends OvertimeEvent{
  final String? dateRange;
  RefreshAllOvertimeStarted({required this.dateRange});
}
class AddOvertimeStarted extends OvertimeEvent{
  final String userId;
  final String fromDate;
  final String toDate;
  final String notes;
  final String reason;
  final String duration ;
  AddOvertimeStarted(
    {
      required this.userId,
      required this.fromDate,
      required this.toDate,
      required this.notes,
      required this.reason,
      required this.duration,
    }
  );
}
class UpdateOvertimeStarted extends OvertimeEvent{
  final String id;
  final String userId;
  final String fromDate;
  final String toDate;
  final String notes;
  final String reason;
   final String duration ;
  UpdateOvertimeStarted(
    {
      required this.userId,
      required this.fromDate,
      required this.toDate,
      required this.notes,
      required this.reason,
      required this.id,
      required this.duration,
    }
  );
}

class UpdateOvertimeStatusStarted extends OvertimeEvent{
  final String id;
  final String status;
  final String paytype;
  UpdateOvertimeStatusStarted({
    required this.id,
    required this.status,
    required this.paytype
  });
}
class DeleteOvertimeStarted extends OvertimeEvent{
  final String id;
  DeleteOvertimeStarted({
    required this.id,
  });
}