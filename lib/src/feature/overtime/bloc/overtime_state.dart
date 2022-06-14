import 'package:equatable/equatable.dart';

class OvertimeState extends Equatable {
  OvertimeState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizingOvertime extends OvertimeState{}

class InitailizedOvertime extends OvertimeState{}

class FetchingOvertime extends OvertimeState{}

class FetchedOvertime extends OvertimeState{}

class EndofOvertimeList extends OvertimeState{}

class ErrorFetchingOvertime extends OvertimeState{
  final dynamic error;
  ErrorFetchingOvertime({required this.error});
}
class AddingOvertime extends OvertimeState{}

class AddedOvertime extends OvertimeState{}

class ErrorAddingOvertime extends OvertimeState{
  final dynamic error;
  ErrorAddingOvertime({required this.error});
}
