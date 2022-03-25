import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class AddLeaveType extends StatefulWidget {
  const AddLeaveType({ Key? key }) : super(key: key);

  @override
  State<AddLeaveType> createState() => _AddLeaveTypeState();
}

class _AddLeaveTypeState extends State<AddLeaveType> {
  final TextEditingController _nameCtrl = TextEditingController();
    final TextEditingController _noteCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Add Leavetype"),
      body: Builder(builder: (context) {
        return BlocListener<LeaveTypeBloc, LeaveTypeState>(
          listener: (context, state) {
            if (state is AddingLeaveType) {
              loadingDialogs(context);
            }
            if (state is ErrorAddingLeaveType) {
              Navigator.pop(context);
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedLeaveType) {
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
                        controller: _nameCtrl,
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
                            labelText: "Leavetype name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Leavetype name';
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
                        //     return 'Leavetype name';
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
                BlocProvider.of<LeaveTypeBloc>(context).add(AddLeaveTypeStarted(name: _nameCtrl.text, note: _noteCtrl.text));
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
