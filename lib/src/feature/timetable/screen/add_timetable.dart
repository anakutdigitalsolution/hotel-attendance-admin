import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/timetable_bloc.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddTimetable extends StatefulWidget {
  const AddTimetable({Key? key}) : super(key: key);

  @override
  State<AddTimetable> createState() => _AddTimetableState();
}

class _AddTimetableState extends State<AddTimetable> {
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _ondutyCtrl = TextEditingController();
  final TextEditingController _ofDutyCtrl = TextEditingController();
  final TextEditingController _lateMnCtrl = TextEditingController();
  final TextEditingController _earlyMnCtrl = TextEditingController();
  //  final TextEditingController _reasonCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Add Timetable"),
      body: Builder(builder: (context) {
        return BlocListener<TimetableBloc, TimetableState>(
          listener: (context, state) {
            if (state is AddingTimetable) {
              loadingDialogs(context);
            }
            if (state is ErrorAddingTimetable) {
              Navigator.pop(context);
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedTimetable) {
              // BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
              // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
              Navigator.pop(context);
              Navigator.pop(context);

              print("success");
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
                                Radius.circular(5.0),
                              ),
                              borderSide: new BorderSide(
                                width: 1,
                              ),
                            ),
                            isDense: true,
                            labelText: "Timetalbe name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Timetalbe name';
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
                                Radius.circular(5.0),
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
                                Radius.circular(5.0),
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
                                Radius.circular(5.0),
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
                                Radius.circular(5.0),
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
                    ],
                  ),
                ),
              )
            ],
          ),
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
                BlocProvider.of<TimetableBloc>(context).add(AddTimetableStarted(
                    name: _reasonCtrl.text,
                    offDuty: _ofDutyCtrl.text,
                    onDuty: _ondutyCtrl.text,
                    lateMn: _lateMnCtrl.text,
                    earlyMn: _earlyMnCtrl.text));
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
