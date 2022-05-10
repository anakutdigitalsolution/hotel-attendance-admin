import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/group/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/group/model/group_model.dart';
import 'package:hotle_attendnce_admin/src/feature/location/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import 'department_page.dart';

class EditDepartment extends StatefulWidget {
  final DepartmentModel departmentModel;
  const EditDepartment({required this.departmentModel});

  @override
  State<EditDepartment> createState() => _EditDepartmentState();
}

class _EditDepartmentState extends State<EditDepartment> {
  LocationBloc _locationBloc = LocationBloc();
  GroupBloc _groupBloc = GroupBloc();
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _groupIdCtrl = TextEditingController();
  final TextEditingController _locationCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _reasonCtrl.text = widget.departmentModel.name!;
    widget.departmentModel.notes == null
        ? _noteCtrl.text = ""
        : _noteCtrl.text = widget.departmentModel.notes!;
    _locationCtrl.text = widget.departmentModel.locationModel!.name!;
    _groupIdCtrl.text = widget.departmentModel.groupModel!.name!;
    super.initState();
  }

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
              bloc: _groupBloc,
              listener: (context, state) {
                if (state is FetchingGroup) {
                  loadingDialogs(context);
                }
                if (state is ErrorFetchingGroup) {
                  Navigator.pop(context);
                  errorSnackBar(text: state.toString(), context: context);
                }
                if (state is FetchedGroup) {
                  Navigator.pop(context);
                  customModal(context,
                      _groupBloc.departmentList.map((e) => e.name!).toList(),
                      (value) {
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
                                      Radius.circular(5.0),
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
                                _groupBloc.add(FetchAllGroupStarted());
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
                                  labelText: "Choose group  "),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'group is required.';
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
                                      Radius.circular(5.0),
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
                                    String locationId = "";
                                    String groupId = "";
                                    if (_groupIdCtrl.text !=
                                        widget.departmentModel.groupModel!
                                            .name!) {
                                      GroupModel groupModel = _groupBloc
                                          .departmentList
                                          .firstWhere((element) =>
                                              element.name ==
                                              _groupIdCtrl.text);
                                      groupId = groupModel.id;
                                    } else {
                                      groupId = widget.departmentModel.groupId!;
                                    }
                                    if (_locationCtrl.text !=
                                        widget.departmentModel.locationModel!
                                            .name) {
                                      LocationModel locationModel =
                                          _locationBloc.departmentList
                                              .firstWhere((element) =>
                                                  element.name ==
                                                  _locationCtrl.text);
                                      locationId = locationModel.id;
                                    } else {
                                      locationId =
                                          widget.departmentModel.locationId!;
                                    }

                                    departmentBlc.add(UpdateDepartmentStarted(
                                        id: widget.departmentModel.id,
                                        name: _reasonCtrl.text,
                                        locationId: locationId,
                                        groupId: groupId,
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
