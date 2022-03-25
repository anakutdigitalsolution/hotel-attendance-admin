import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/bloc/employee_timetable_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

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
        return BlocListener<EmployeeTimetableBloc, EmployeeTimetableState>(
          listener: (context, state) {
            if (state is AddingEmployeeTimetable) {
              loadingDialogs(context);
            }
            if (state is ErrorAddingEmployeeTimetable) {
              Navigator.pop(context);
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedEmployeeTimetable) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          child: BlocListener<EmployeeBloc, EmployeeState>(
              listener: (context, state) {
                if (state is InitializingEmployee) {
                  loadingDialogs(context);
                }
                if (state is ErrorFetchingEmployee) {
                  Navigator.pop(context);
                  errorSnackBar(text: state.error.toString(), context: context);
                }
                if (state is InitializedEmployee) {
                  Navigator.pop(context);
                  customModal(
                      context,
                      BlocProvider.of<EmployeeBloc>(context)
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
              child: BlocListener<TimetableBloc, TimetableState>(
                listener: (context, state) {
                  if (state is InitializingTimetable) {
                    loadingDialogs(context);
                  }
                  if (state is ErrorFetchingTimetable) {
                    Navigator.pop(context);
                    errorSnackBar(
                        text: state.error.toString(), context: context);
                  }
                  if (state is InitializedTimetable) {
                    Navigator.pop(context);
                    customModal(
                        context,
                        BlocProvider.of<TimetableBloc>(context)
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
                                BlocProvider.of<EmployeeBloc>(context)
                                    .add(InitializeEmployeeStarted());
                              },
                              readOnly: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  contentPadding: EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
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
                              controller: _empCtl,
                              onTap: () {
                                BlocProvider.of<TimetableBloc>(context)
                                    .add(InitializeTimetableStarted());
                              },
                              readOnly: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  contentPadding: EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
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
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        );
      }),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        height: 50,
        width: double.infinity,
        child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              // side: BorderSide(color: Colors.red)
            ),
            color: Colors.blue,
            onPressed: () {
              if (_formKey!.currentState!.validate()) {
                EmployeeModel employeeId =
                    BlocProvider.of<EmployeeBloc>(context)
                        .emploList
                        .firstWhere((element) => element.name == _empCtl.text);

                TimetableModel timetableId =
                    BlocProvider.of<TimetableBloc>(context)
                        .timetableList
                        .firstWhere((element) =>
                            element.timetableName == _timeCtrl.text);
                BlocProvider.of<EmployeeTimetableBloc>(context).add(
                    AddEmployeeTimetableStarted(
                        employeeId: employeeId.id,
                        timetableId: timetableId.id));
              }
            },
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Submit",
              // AppLocalizations.of(context)!.translate("submit")!,
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
