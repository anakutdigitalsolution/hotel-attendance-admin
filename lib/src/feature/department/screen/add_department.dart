import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/department_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';

import 'package:hotle_attendnce_admin/src/feature/location/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/bloc/working_day_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/bloc/working_day_event.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/bloc/working_day_state.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import 'department_page.dart';

class AddDepartment extends StatefulWidget {
  // final bool isGroup;
  // final String? groupId;
  // const AddDepartment({this.isGroup = false,required this.groupId});

  @override
  State<AddDepartment> createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  LocationBloc _locationBloc = LocationBloc();
  // GroupBloc _groupBloc = GroupBloc();
  WorkingDayBloc _workingDayBloc = WorkingDayBloc();
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _groupIdCtrl = TextEditingController();
  final TextEditingController _locationCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Add Department"),
      body: Builder(builder: (context) {
        return BlocListener(
            bloc: departmentBlc,
            listener: (context, state) {
              if (state is AddingDepartment) {
                EasyLoading.show(status: "loading....");
              }
              if (state is ErrorAddingDepartment) {
                EasyLoading.dismiss();
                EasyLoading.showError(state.error.toString());
                // Navigator.pop(context);
                // errorSnackBar(text: state.error.toString(), context: context);
              }
              if (state is AddedDepartment) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Success");
                Navigator.pop(context);
              }
            },
            child: BlocListener(
              bloc: _workingDayBloc,
              listener: (context, state) {
                if (state is FetchingWorkingDay) {
                  loadingDialogs(context);
                }
                if (state is ErrorFetchingWorkingDay) {
                  Navigator.pop(context);
                  errorSnackBar(text: state.toString(), context: context);
                }
                if (state is FetchedWorkingDay) {
                  Navigator.pop(context);
                  customModal(
                      context,
                      _workingDayBloc.departmentList
                          .map((e) =>
                              "${e.name}  Workday ${e.workingDay} Offday ${e.offDay}")
                          .toList(), (value) {
                    _groupIdCtrl.text = value;
                  });
                }
              },
              child: BlocListener(
                bloc: _locationBloc,
                listener: (context, state) {
                  if (state is FetchingLocation) {
                    loadingDialogs(context);
                  }
                  if (state is ErrorFetchingLocation) {
                    Navigator.pop(context);
                    errorSnackBar(text: state.toString(), context: context);
                  }
                  if (state is FetchedLocation) {
                    Navigator.pop(context);
                    customModal(
                        context,
                        _locationBloc.departmentList
                            .map((e) => e.name!)
                            .toList(), (value) {
                      _locationCtrl.text = value;
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
                              controller: _reasonCtrl,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
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
                                  labelText: "Department name"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Department name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _groupIdCtrl,
                              onTap: () {
                                _workingDayBloc
                                    .add(FetchAllWorkingdayStarted());
                              },
                              readOnly: true,
                              // keyboardType: TextInputType.text,
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
                                  labelText: "Choose work days  "),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'workday is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _locationCtrl,
                              onTap: () {
                                _locationBloc.add(FetchAllLocationStarted());
                              },
                              readOnly: true,
                              // keyboardType: TextInputType.text,
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
                                  labelText: "Choose location  "),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'loation is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _noteCtrl,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
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
                                  labelText: "Notes"),
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'Department name';
                              //   }
                              //   return null;
                              // },
                            ),
                            // SizedBox(height: 15),
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 4),
                            standardBtn(
                                title: "Submit",
                                onTap: () {
                                  if (_formKey!.currentState!.validate()) {
                                    LocationModel locationModel = _locationBloc
                                        .departmentList
                                        .firstWhere((element) =>
                                            element.name == _locationCtrl.text);
                                    WorkingDayModel workingDayModel =
                                        _workingDayBloc.departmentList
                                            .firstWhere((e) =>
                                                "${e.name}  Workday ${e.workingDay} Offday ${e.offDay}" ==
                                                _groupIdCtrl.text);
                                    departmentBlc.add(AddDepartmentStarted(
                                        name: _reasonCtrl.text,
                                        locationId: locationModel.id,
                                        workId: workingDayModel.id,
                                        notes: _noteCtrl.text));
                                  }
                                })
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
