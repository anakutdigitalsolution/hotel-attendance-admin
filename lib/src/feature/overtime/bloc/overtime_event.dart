
import 'package:equatable/equatable.dart';

class OverTimeEvent extends Equatable {
  OverTimeEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailzeMyOvertimeStarted extends OverTimeEvent{
   final String? dateRange;
  InitailzeMyOvertimeStarted({required this.dateRange});
}
class InitializeAllOvertimeStarted extends OverTimeEvent {
  final String? dateRange;
  InitializeAllOvertimeStarted({required this.dateRange});
}


class FetchMyOvertimeStarted extends OverTimeEvent{
   final String? dateRange;
  FetchMyOvertimeStarted({required this.dateRange});
}
class FetchAllOvertimeStarted extends OverTimeEvent{
   final String? dateRange;
  FetchAllOvertimeStarted({required this.dateRange});
}
class RefreshMyOvertimeStarted extends OverTimeEvent{
   final String? dateRange;
  RefreshMyOvertimeStarted({required this.dateRange});
}
class RefreshAllOvertimeStarted extends OverTimeEvent{
  final String? dateRange;
  RefreshAllOvertimeStarted({required this.dateRange});
}
class AddOvertimeStarted extends OverTimeEvent{
  final String userId;
  final String fromDate;
  final String toDate;
  final String notes;
  final String reason;
  final String type;
  final String duration ;
  AddOvertimeStarted(
    {
      required this.userId,
      required this.fromDate,
      required this.toDate,
      required this.notes,
      required this.reason,
      required this.type,
      required this.duration,
    }
  );
}
class UpdateOvertimeStarted extends OverTimeEvent{
  final String id;
  final String userId;
  final String fromDate;
  final String toDate;
  final String notes;
  final String reason;
  final String type;
   final String duration ;
  UpdateOvertimeStarted(
    {
      required this.userId,
      required this.fromDate,
      required this.toDate,
      required this.notes,
      required this.reason,
      required this.id,
      required this.type,
      required this.duration,
    }
  );
}

class UpdateOvertimeStatusStarted extends OverTimeEvent{
  final String id;
  final String status;
  final String paytype;
  UpdateOvertimeStatusStarted({
    required this.id,
    required this.status,
    required this.paytype
  });
}
class DeleteOvertimeStarted extends OverTimeEvent{
  final String id;
  DeleteOvertimeStarted({
    required this.id,
  });
}