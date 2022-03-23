import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_event.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_state.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/repository/employee_repository.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(InitializingEmployee());
  EmployeeRepository departmentRepository = EmployeeRepository();
  List<EmployeeModel> emploList = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event) async* {
    if (event is InitializeEmployeeStarted) {
      yield InitializingEmployee();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        emploList = await departmentRepository.getEmployee(
            rowPerpage: rowperpage, page: page);
        page++;
        print(page);
        print(emploList.length);
        if (emploList.length < rowperpage) {
          yield EndofEmployeeList();
        } else {
          yield InitializedEmployee();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingEmployee(error: e.toString());
      }
    }
    if (event is FetchEmloyeeStarted) {
      yield FetchingEmployee();
      try {
        List<EmployeeModel> _departmentList = await departmentRepository
            .getEmployee(rowPerpage: rowperpage, page: page);

        emploList.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndofEmployeeList();
        } else {
          yield FetchedEmployee();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingEmployee(error: e.toString());
      }
    }
    if (event is AddEmployeeStarted) {
      yield AddingEmployee();
      try {
        await departmentRepository.addEmployee(
            name: event.name,
            gender: event.gender,
            img: event.img,
            username: event.username,
            password: event.password,
            positionId: event.positionId,
            departmentId: event.departmentId,
            storeId: event.storeId,
            phoneNumber: event.phoneNumber,
            address: event.address);
        yield AddedEmployee();
        yield FetchingEmployee();
        print(emploList.length);
        emploList.clear();
        emploList = await departmentRepository.getEmployee(
            rowPerpage: rowperpage, page: 1);
        print(emploList.length);
        yield FetchedEmployee();
      } catch (e) {
        log(e.toString());
        yield ErorrAddingEmployee(error: e.toString());
      }
    }
    if (event is UpdateEmployeeStarted) {
      yield AddingEmployee();
      try {
        await departmentRepository.editEmployee(
            id: event.id,
            name: event.name,
            gender: event.gender,
            img: event.img,
            // username: event.username,
            // password: event.password,
            positionId: event.positionId,
            departmentId: event.departmentId,
            storeId: event.storeId,
            phoneNumber: event.phoneNumber,
            address: event.address);
        yield AddedEmployee();
        yield FetchingEmployee();
        print(emploList.length);
        emploList.clear();
        emploList = await departmentRepository.getEmployee(
            rowPerpage: rowperpage, page: 1);
        print(emploList.length);
        yield FetchedEmployee();
      } catch (e) {
        log(e.toString());
        yield ErorrAddingEmployee(error: e.toString());
      }
    }
    if (event is DeleteEmployeeStarted) {
      yield AddingEmployee();
      try {
        await departmentRepository.deleteEmployee(id: event.id);
        // yield FetchingEmployee();

        yield AddedEmployee();
        yield FetchingEmployee();
        print(emploList.length);
        emploList.clear();
        emploList = await departmentRepository.getEmployee(
            rowPerpage: rowperpage, page: 1);
        print(emploList.length);
        yield FetchedEmployee();
      } catch (e) {
        log(e.toString());
        yield ErorrAddingEmployee(error: e.toString());
      }
    }
  }
}
