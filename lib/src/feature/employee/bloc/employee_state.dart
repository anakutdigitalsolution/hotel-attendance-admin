import 'package:equatable/equatable.dart';
import 'package:hotle_attendnce_admin/src/utils/share/app_constant.dart';

abstract class EmployeeState extends Equatable{
   EmployeeState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}
class InitializingEmployee extends EmployeeState{}
class FetchingAllEmployee extends EmployeeState{}
class FetchedAllEmployee extends EmployeeState{}
class InitializedEmployee extends EmployeeState{}
class FetchingEmployee extends EmployeeState{}
class FetchedEmployee extends EmployeeState{}
class EndofEmployeeList extends EmployeeState{}

class AddingEmployee extends EmployeeState{
  
}
class AddedEmployee extends EmployeeState{}
class ErorrAddingEmployee extends EmployeeState{
    final dynamic error;
  ErorrAddingEmployee({
    required this.error
  });
}
class ErrorFetchingEmployee extends EmployeeState with ErrorState{
  final dynamic error;
  ErrorFetchingEmployee({
    required this.error
  });
}
// class AddingCheckin extends EmployeeState {}
// class AddedCheckin extends EmployeeState {}
// class ErrorAddingCheckInOut extends EmployeeState {
//   final dynamic error;
//   ErrorAddingCheckInOut({
//     required this.error
//   });
// }

class ChangeFailed extends EmployeeState {
  final dynamic error;

  ChangeFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class Changed extends EmployeeState {
  Changed({required this.accessToken});
  final String accessToken;
}

class Changing extends EmployeeState {}
