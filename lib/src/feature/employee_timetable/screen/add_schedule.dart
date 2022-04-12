import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/employee_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/bloc/employee_timetable_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/screen/timetable_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import 'shedule_page.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final TextEditingController _empCtl = TextEditingController();
  final TextEditingController _timeCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Add Schedule"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: employeeTimetableBloc,
          listener: (context, state) {
            if (state is AddingEmployeeTimetable) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingEmployeeTimetable) {
              Navigator.pop(context);
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedEmployeeTimetable) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Sucess");
              Navigator.pop(context);
            }
          },
          child: BlocListener(
              bloc: employeeBloc,
              listener: (context, stae) {
                if (stae is FetchingEmployee) {
                  loadingDialogs(context);
                  print("fetching data");
                }
                if (stae is ErrorFetchingEmployee) {
                  Navigator.pop(context);
                  print("errir");
                  errorSnackBar(text: stae.error.toString(), context: context);
                }
                if (stae is FetchedEmployee) {
                  print("hi");
                  Navigator.pop(context);
                  customModal(
                      context,
                      employeeBloc
                          .emploList
                          .map((e) => e.name)
                          .toList(), (value) {
                    _empCtl.text = value;
                    // roomTypeModel = BlocProvider.of<RoomTypeBloc>(context)
                    //     .roomtype
                    //     .firstWhere((roomtype) => roomtype.type == value);
                    // _roomNumberCtrl.clear();
                    // _stayingCtrl.clear();
                  });
                }
              },
              child: BlocListener(
                bloc: timetableBloc,
                listener: (context, state) {
                  if (state is FetchingTimetable) {
                    loadingDialogs(context);
                  }
                  if (state is ErrorFetchingTimetable) {
                    Navigator.pop(context);
                    errorSnackBar(
                        text: state.error.toString(), context: context);
                  }
                  if (state is FetchedTimetable) {
                    Navigator.pop(context);
                    customModal(
                        context,
                       timetableBloc
                            .timetableList
                            .map((e) => e.timetableName)
                            .toList(), (value) {
                      _timeCtrl.text = value;
                      // roomTypeModel = BlocProvider.of<RoomTypeBloc>(context)
                      //     .roomtype
                      //     .firstWhere((roomtype) => roomtype.type == value);
                      // _roomNumberCtrl.clear();
                      // _stayingCtrl.clear();
                    });
                  }
                },
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _empCtl,
                              onTap: () {
                                employeeBloc
                                    .add(FetchAllEmployeeStarted());
                              },
                              readOnly: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  contentPadding: EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    borderSide: new BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  isDense: true,
                                  labelText: "Select Employee"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Employee is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _timeCtrl,
                              onTap: () {
                                timetableBloc
                                    .add(FetchAllTimetableStarted());
                              },
                              readOnly: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  contentPadding: EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    borderSide: new BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  isDense: true,
                                  labelText: "Select Timetable"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Timetable is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 4),
                            standardBtn(
                                title: "Submit",
                                onTap: () {
                                  if (_formKey!.currentState!.validate()) {
                                    EmployeeModel employeeId =
                                        employeeBloc
                                            .emploList
                                            .firstWhere((element) =>
                                                element.name == _empCtl.text);

                                    TimetableModel timetableId =
                                        timetableBloc
                                            .timetableList
                                            .firstWhere((element) =>
                                                element.timetableName ==
                                                _timeCtrl.text);
                                    employeeTimetableBloc
                                        .add(AddEmployeeTimetableStarted(
                                            employeeId: employeeId.id,
                                            timetableId: timetableId.id));
                                  }
                                })
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        );
      }),
    );
  }
}
