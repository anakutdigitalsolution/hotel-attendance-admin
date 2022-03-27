import 'package:equatable/equatable.dart';

class DepartmentEvent extends Equatable {
  DepartmentEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchDepartmentStarted extends DepartmentEvent {}
class FetchAllDepartmentStarted extends DepartmentEvent{}

class InitializeDepartmentStarted extends DepartmentEvent {}

class RefreshDepartmentStarted extends DepartmentEvent {}

class AddDepartmentStarted extends DepartmentEvent {
  final String name;

  AddDepartmentStarted({
    required this.name,
  });
}

class UpdateDepartmentStarted extends DepartmentEvent {
  final String id;
  final String name;
  UpdateDepartmentStarted({required this.id, required this.name});
}

class DeleteDepartmentStarted extends DepartmentEvent {
  final String id;
  // final String date;
  DeleteDepartmentStarted({
    required this.id,
  });
}
