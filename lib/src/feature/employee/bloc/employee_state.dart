import 'package:equatable/equatable.dart';

abstract class EmployeeState extends Equatable{
   EmployeeState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}
class InitializingEmployee extends EmployeeState{}
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
class ErrorFetchingEmployee extends EmployeeState{
  final dynamic error;
  ErrorFetchingEmployee({
    required this.error
  });
}
