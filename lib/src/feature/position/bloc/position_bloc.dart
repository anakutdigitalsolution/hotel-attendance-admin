import 'dart:developer';

import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/department/repository/department_repository.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/model/leave_model.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/model/leave_type_model.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/repository/leave_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class PositionBlc extends Bloc<PositionEvent, PositionState> {
  PositionBlc() : super(InitializingPosition());

  DepartmentRepository departmentRepository = DepartmentRepository();
  List<DepartmentModel> departmentList = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<PositionState> mapEventToState(PositionEvent event) async* {
    if (event is InitializeDepartmentStarted) {
      yield InitializingPosition();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        departmentList = await departmentRepository.getdepartment(
            rowPerpage: rowperpage, page: page);

        page++;
        print(page);
        print(departmentList.length);
        if (departmentList.length < rowperpage) {
          yield EndOfPositionList();
        } else {
          yield InitializedPosition();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPosition(error: e.toString());
      }
    }
    if (event is FetchDepartmentStarted) {
      yield FetchingPosition();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<DepartmentModel> _departmentList = await departmentRepository
            .getdepartment(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndOfPositionList();
        } else {
          yield FetchedPosition();
        }
      } catch (e) {
        yield ErrorFetchingPosition(error: e.toString());
      }
    }

    if (event is RefreshDepartmentStarted) {
      yield FetchingPosition();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        if (departmentList.length != 0) {
          departmentList.clear();
        }
        List<DepartmentModel> leaveList = await departmentRepository
            .getdepartment(rowPerpage: rowperpage, page: page);
        departmentList.addAll(leaveList);
        print(leaveList.length);
        // page++;
        yield FetchedPosition();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPosition(error: e.toString());
      }
    }
    if (event is AddPositionStarted) {
      yield AddingPosition();
      try {
        await departmentRepository.addDepartment(name: event.name);

        yield AddedPosition();
        yield FetchingPosition();
        print(departmentList.length);
        departmentList.clear();
        departmentList = await departmentRepository.getdepartment(
            rowPerpage: rowperpage, page: 1);
        print(departmentList.length);
        yield FetchedPosition();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingPosition(error: e.toString());
      }
    }
    // if (event is UpdateDepartmentStarted) {
    //   yield AddingPosition();
    //   try {
    //     await departmentRepository.editDepartment(
    //         id: event.id, name: event.name);

    //     yield AddedDepartment();
    //     yield FetchingDepartment();
    //     print(departmentList.length);
    //     departmentList.clear();
    //     departmentList = await departmentRepository.getdepartment(
    //         rowPerpage: rowperpage, page: 1);
    //     print(departmentList.length);
    //     yield FetchedPosition();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErrorAddingPosition(error: e.toString());
    //   }
    // }
    // if (event is DeleteDepartmentStarted) {
    //   yield AddingDepartment();
    //   try {
    //     await departmentRepository.deleteDepartment(id: event.id);

    //     yield AddedDepartment();
    //     yield FetchingDepartment();
    //     print(departmentList.length);
    //     departmentList.clear();
    //     departmentList = await departmentRepository.getdepartment(
    //         rowPerpage: rowperpage, page: 1);
    //     print(departmentList.length);
    //     yield FetchedDepartment();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErrorAddingPosition(error: e.toString());
    //   }
    // }
  }
}
