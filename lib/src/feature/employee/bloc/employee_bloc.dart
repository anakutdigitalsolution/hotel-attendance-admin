import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_event.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_state.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/repository/employee_repository.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(FetchingEmployee());
  EmployeeRepository departmentRepository = EmployeeRepository();
  List<EmployeeModel> emploList = [];
  int rowperpage = 12;
  String? image;
  int page = 1;
  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event) async* {
    if (event is FetchEmloyeeStarted) {
      yield FetchingEmployee();
      try {
        print(page);
        print(emploList.length);
        List<EmployeeModel> _departmentList = await departmentRepository
            .getEmployee(rowPerpage: rowperpage, page: page);

        emploList.addAll(_departmentList);
        page++;
        print(page);
        print(emploList.length);
        // yield FetchedEmployee();
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          print(emploList.length);
          yield EndofEmployeeList();
        } else {
          yield FetchedEmployee();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingEmployee(error: e.toString());
      }
    }
    if (event is InitializeEmployeeStarted) {
      yield InitializingEmployee();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        print(page);
        List<EmployeeModel> _departmentList = await departmentRepository
            .getEmployee(rowPerpage: rowperpage, page: page);

        emploList.addAll(_departmentList);
        page++;
        print(page);
        print(emploList.length);
        yield InitializedEmployee();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingEmployee(error: e.toString());
      }
    }
    if (event is RefreshEmployeeStarted) {
      yield FetchingEmployee();
      try {
        page = 1;
        if (emploList.length != 0) {
          emploList.clear();
        }
        List<EmployeeModel> _departmentList = await departmentRepository
            .getEmployee(rowPerpage: rowperpage, page: page);

        emploList.addAll(_departmentList);
        page++;
        yield FetchedEmployee();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingEmployee(error: e.toString());
      }
    }
    if (event is FetchAllEmployeeStarted) {
      yield FetchingEmployee();
      try {
        if (emploList.length != 0) {
          emploList.clear();
        }
        emploList = await departmentRepository.getAllEmployee();
        yield FetchedEmployee();
      } catch (e) {
        yield ErrorFetchingEmployee(error: e.toString());
      }
    }

    if (event is AddEmployeeStarted) {
      yield AddingEmployee();
      try {
        if (event.img == null) {
          image = "";
        } else {
          image = await uploadImage(image: event.img!);
          print(image);
        }
        await departmentRepository.addEmployee(
            name: event.name,
            gender: event.gender,
            dob: event.dob,
            email: event.email,
            officeTel: event.officeTel,
            img: image!,
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
          page =1;
         List<EmployeeModel> _departmentList = await departmentRepository
            .getEmployee(rowPerpage: rowperpage, page: page);

        emploList.addAll(_departmentList);
        page++;
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
        if (event.img == null) {
          image = event.imgUrl;
        } else {
          image = await uploadImage(image: event.img!);
        }
        await departmentRepository.editEmployee(
            id: event.id,
            name: event.name,
            gender: event.gender,
            dob: event.dob,
            email: event.email,
            officeTel: event.officeTel,
            img: image!,
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
          page =1;
         List<EmployeeModel> _departmentList = await departmentRepository
            .getEmployee(rowPerpage: rowperpage, page: page);

        emploList.addAll(_departmentList);
        page++;
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
          page =1;
         List<EmployeeModel> _departmentList = await departmentRepository
            .getEmployee(rowPerpage: rowperpage, page: page);

        emploList.addAll(_departmentList);
        page++;
        print(emploList.length);
        yield FetchedEmployee();
      } catch (e) {
        log(e.toString());
        yield ErorrAddingEmployee(error: e.toString());
      }
    }
  }
}
