import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/model/leave_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class EditLeaveStatus extends StatefulWidget {
  final LeaveModel leaveModel;
  const EditLeaveStatus({required this.leaveModel});
  @override
  State<EditLeaveStatus> createState() => _EditLeaveStatusState();
}

class _EditLeaveStatusState extends State<EditLeaveStatus> {
  final TextEditingController _genderCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Edit leave"),
      body: Builder(builder: (context) {
        return BlocListener<LeaveBloc, LeaveState>(
            listener: (context, state) {
              if (state is AddingLeave) {
                loadingDialogs(context);
              }
              if (state is ErrorAddingLeave) {
                Navigator.pop(context);
                errorSnackBar(text: state.error.toString(), context: context);
              }
              if (state is AddedLeave) {
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
                          controller: _genderCtrl,
                          // keyboardType: TextInputType.text,
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
                              labelText: "Status"),
                          onTap: () {
                            _showDialog(context);
                          },
                          readOnly: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please status';
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
                              labelText: "Note"),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ));
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
                BlocProvider.of<LeaveBloc>(context).add(
                    UpdateLeaveStatusStarted(
                        id: widget.leaveModel.id, status: _genderCtrl.text));
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

  void _showDialog(context) {
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Alert'),
    //         content: Text("Are you want to leave?"),
    //         actions: <Widget>[
    //           FlatButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             child: Text('NO'),
    //           ),
    //           FlatButton(
    //             onPressed: () {
    //               BlocProvider.of<
    //                           AuthenticationBloc>(
    //                       context)
    //                   .add(LogoutPressed());
    //               Navigator.pop(context);
    //               Navigator.pop(context);
    //             },
    //             child: Text('Yes'),
    //           ),
    //         ],
    //       );
    //     });
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      title: new Text("Approve"),
                      onTap: () {
                        _genderCtrl.text = "approved";
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    title: new Text("Reject"),
                    onTap: () {
                      _genderCtrl.text = "rejected";
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
