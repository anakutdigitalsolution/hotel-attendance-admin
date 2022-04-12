import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/screen/timetable_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

class EditTimetable extends StatefulWidget {
  final TimetableModel timetableModel;
  const EditTimetable({required this.timetableModel});

  @override
  State<EditTimetable> createState() => _EditTimetableState();
}

class _EditTimetableState extends State<EditTimetable> {
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _ondutyCtrl = TextEditingController();
  final TextEditingController _ofDutyCtrl = TextEditingController();
  final TextEditingController _lateMnCtrl = TextEditingController();
  final TextEditingController _earlyMnCtrl = TextEditingController();
  //  final TextEditingController _reasonCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _reasonCtrl.text = widget.timetableModel.timetableName;
    _ondutyCtrl.text = widget.timetableModel.onDutyTtime;
    _ofDutyCtrl.text = widget.timetableModel.offDutyTime;
    _lateMnCtrl.text = widget.timetableModel.lateMn!;
    _earlyMnCtrl.text = widget.timetableModel.earlyMn!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Edit Timetable"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: timetableBloc,
          listener: (context, state) {
            if (state is AddingTimetable) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingTimetable) {
              Navigator.pop(context);
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedTimetable) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Sucess");
              Navigator.pop(context);
            }
          },
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                            labelText: "Timetable name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Timetable name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _ondutyCtrl,
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
                            labelText: "On duty"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'On duty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _ofDutyCtrl,
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
                            labelText: "Off duty"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Off duty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _lateMnCtrl,
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
                            labelText: "Late minutes"),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Off duty';
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _earlyMnCtrl,
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
                            labelText: "Early minutes"),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Off duty';
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 4),
                      standardBtn(
                          title: "Update",
                          onTap: () {
                            if (_formKey!.currentState!.validate()) {
                              timetableBloc.add(
                                  UpdateTimetableStarted(
                                      id: widget.timetableModel.id,
                                      name: _reasonCtrl.text,
                                      offDuty: _ofDutyCtrl.text,
                                      onDuty: _ondutyCtrl.text,
                                      lateMn: _lateMnCtrl.text,
                                      earlyMn: _earlyMnCtrl.text));
                            }
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
      
    );
  }
}
