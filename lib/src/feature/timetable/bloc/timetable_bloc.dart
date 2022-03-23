import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/repository/timetable_repository.dart';

class TimetableBloc extends Bloc<TimetabletEvent, TimetableState> {
  TimetableBloc() : super(InitializingTimetable());
  TimetableRepository departmentRepository = TimetableRepository();
  List<TimetableModel> timetableList = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<TimetableState> mapEventToState(TimetabletEvent event) async* {
    if (event is InitializeTimetableStarted) {
      yield InitializingTimetable();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        timetableList = await departmentRepository.getTimetable(
            rowPerpage: rowperpage, page: page);
        page++;
        print(page);
        print(timetableList.length);
        if (timetableList.length < rowperpage) {
          yield EndOfTimetableList();
        } else {
          yield InitializedTimetable();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingTimetable(error: e.toString());
      }
    }
    if (event is FetchTimetableStarted) {
      yield FetchingTimetable();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<TimetableModel> _departmentList = await departmentRepository
            .getTimetable(rowPerpage: rowperpage, page: page);

        timetableList.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndOfTimetableList();
        } else {
          yield FetchedTimetable();
        }
      } catch (e) {
        yield ErrorFetchingTimetable(error: e.toString());
      }
    }

    if (event is RefreshTimetableStarted) {
      yield FetchingTimetable();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        if (timetableList.length != 0) {
          timetableList.clear();
        }
        List<TimetableModel> leaveList = await departmentRepository
            .getTimetable(rowPerpage: rowperpage, page: page);
        timetableList.addAll(leaveList);
        print(leaveList.length);
        // page++;
        yield FetchedTimetable();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingTimetable(error: e.toString());
      }
    }
    if (event is AddTimetableStarted) {
      yield AddingTimetable();
      try {
        await departmentRepository.addTimetable(
            name: event.name, onDuty: event.onDuty, offDuty: event.offDuty);

        yield AddedTimetable();
        yield FetchingTimetable();
        print(timetableList.length);
        timetableList.clear();
        timetableList = await departmentRepository.getTimetable(
            rowPerpage: rowperpage, page: 1);
        print(timetableList.length);
        yield FetchedTimetable();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingTimetable(error: e.toString());
      }
    }
    if (event is UpdateTimetableStarted) {
      yield AddingTimetable();
      try {
        await departmentRepository.editTimetable(
            id: event.id,
            name: event.name,
            onDuty: event.onDuty,
            offDuty: event.offDuty);

        yield AddedTimetable();
        yield FetchingTimetable();
        print(timetableList.length);
        timetableList.clear();
        timetableList = await departmentRepository.getTimetable(
            rowPerpage: rowperpage, page: 1);
        print(timetableList.length);
        yield FetchedTimetable();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingTimetable(error: e.toString());
      }
    }
    if (event is DeleteTimetableStarted) {
      yield AddingTimetable();
      try {
        await departmentRepository.deleteTimetable(id: event.id);

        yield AddedTimetable();
        yield FetchingTimetable();
        print(timetableList.length);
        timetableList.clear();
        timetableList = await departmentRepository.getTimetable(
            rowPerpage: rowperpage, page: 1);
        print(timetableList.length);
        yield FetchedTimetable();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingTimetable(error: e.toString());
      }
    }
  }
}