import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/bloc/working_day_event.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/screen/working_day.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

class EditWorkingDay extends StatefulWidget {
  final WorkingDayModel workingDayModel;
  const EditWorkingDay({required this.workingDayModel }) ;

  @override
  State<EditWorkingDay> createState() => _EditWorkingDayState();
}

class _EditWorkingDayState extends State<EditWorkingDay> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _offdayCtrl = TextEditingController();
  final TextEditingController _workingdayCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  // final TextEditingController _earlyMnCtrl = TextEditingController();
  //  final TextEditingController _reasonCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _nameCtrl.text = widget.workingDayModel.name!;
    _offdayCtrl.text = widget.workingDayModel.offDay!;
    _workingdayCtrl.text = widget.workingDayModel.workingDay!;
    widget.workingDayModel.notes ==  null?_noteCtrl.text="":_noteCtrl.text= widget.workingDayModel.notes!;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Edit Working day"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: workingDayBloc,
          listener: (context, state) {
            if (state is AddingWorkingDay) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingWorkingDay) {
              EasyLoading.dismiss();
             EasyLoading.showError(state.error.toString());
            }
            if (state is AddedWorkingDay) {
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
                        controller: _nameCtrl,
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
                            labelText: "Working day name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Working day name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _workingdayCtrl,
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
                            labelText: "Workind day"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'working day is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _offdayCtrl,
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
                            labelText: "Off day is required"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Off day is required';
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
                        //     return 'Off duty';
                        //   }
                        //   return null;
                        // },
                      ),
                      // SizedBox(height: 15),
                      
                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      standardBtn(
                          title: "Update",
                          onTap: () {
                            if (_formKey!.currentState!.validate()) {
                             workingDayBloc.add(
                                  UpdateWorkingdayStarted(
                                    id: widget.workingDayModel.id,
                                      name: _nameCtrl.text,
                                      workDay: _workingdayCtrl.text,
                                      offDay: _offdayCtrl.text,
                                      notes: _noteCtrl.text,
                                ));
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
