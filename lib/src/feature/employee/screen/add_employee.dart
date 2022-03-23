import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/department_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_event.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_state.dart';
import 'package:hotle_attendnce_admin/src/feature/position/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _genderCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _imgCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _storeIdCtrl = TextEditingController();
  final TextEditingController _positionIdCtrl = TextEditingController();
  final TextEditingController _departmentIdCtrl = TextEditingController();
  final TextEditingController _phoneNumberCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Add Employee"),
      body: Builder(builder: (context) {
        return BlocListener<EmployeeBloc, EmployeeState>(
            listener: (context, state) {
              if (state is AddingEmployee) {
                loadingDialogs(context);
              }
              if (state is ErorrAddingEmployee) {
                Navigator.pop(context);
                errorSnackBar(text: state.error.toString(), context: context);
              }
              if (state is AddedEmployee) {
                // BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
                // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
                Navigator.pop(context);
                Navigator.pop(context);

                print("success");
              }
            },
            child: BlocListener<DepartmentBlc, DepartmentState>(
              listener: (context, state) {
                if (state is FetchingDepartment) {
                  loadingDialogs(context);
                }
                if (state is ErrorFetchingDepartment) {
                  Navigator.pop(context);
                  errorSnackBar(text: state.error.toString(), context: context);
                }
                if (state is FetchedDepartment) {
                  Navigator.pop(context);
                  customModal(
                      context,
                      BlocProvider.of<DepartmentBlc>(context)
                          .departmentList
                          .map((e) => e.name)
                          .toList(), (value) {
                    _departmentIdCtrl.text = value;
                    // roomTypeModel = BlocProvider.of<RoomTypeBloc>(context)
                    //     .roomtype
                    //     .firstWhere((roomtype) => roomtype.type == value);
                    // _roomNumberCtrl.clear();
                    // _stayingCtrl.clear();
                  });
                }
              },
              child: BlocListener<PositionBlc, PositionState>(
                listener: (context, state) {
                  if (state is FetchingPosition) {
                    loadingDialogs(context);
                  }
                  if (state is ErrorAddingPosition) {
                    Navigator.pop(context);
                    errorSnackBar(
                        text: state.error.toString(), context: context);
                  }
                  if (state is FetchedPosition) {
                    Navigator.pop(context);
                    customModal(
                        context,
                        BlocProvider.of<PositionBlc>(context)
                            .positionList
                            .map((e) => e.positionName)
                            .toList(), (value) {
                      _positionIdCtrl.text = value;
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
                                  labelText: "Employee name"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Employee name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _genderCtrl,
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
                                  labelText: "Gender"),
                              onTap: () {
                                _showDialog(context);
                              },
                              readOnly: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select gender';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _usernameCtrl,
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
                                  labelText: "Username"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Username is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _passwordCtrl,
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
                                  labelText: "password"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _phoneNumberCtrl,
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
                                  labelText: "Phone number"),
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'phone is required';
                              //   }
                              //   return null;
                              // },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _departmentIdCtrl,
                              onTap: () {
                                BlocProvider.of<DepartmentBlc>(context)
                                    .add(RefreshDepartmentStarted());
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
                                  labelText: "Select deparment"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Department is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _positionIdCtrl,
                              onTap: () {
                                BlocProvider.of<PositionBlc>(context)
                                    .add(RefreshPositionStarted());
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
                                  labelText: "select position"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _addressCtrl,
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
                                  labelText: "Address"),
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'address is required';
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
              ),
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
                DepartmentModel departId =
                    BlocProvider.of<DepartmentBlc>(context)
                        .departmentList
                        .firstWhere((element) =>
                            element.name == _departmentIdCtrl.text);

                PositionModel posiId = BlocProvider.of<PositionBlc>(context)
                    .positionList
                    .firstWhere((element) =>
                        element.positionName == _positionIdCtrl.text);
                BlocProvider.of<EmployeeBloc>(context).add(AddEmployeeStarted(
                    name: _nameCtrl.text,
                    gender: _genderCtrl.text,
                    username: _usernameCtrl.text,
                    img:
                        "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png",
                    password: _passwordCtrl.text,
                    positionId: posiId.id,
                    departmentId: departId.id,
                    storeId: "1",
                    phoneNumber: _phoneNumberCtrl.text,
                    address: _addressCtrl.text));
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
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      title: new Text("ប្រុស"),
                      onTap: () {
                        _genderCtrl.text = "ប្រុស";
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    title: new Text("ស្រី"),
                    onTap: () {
                      _genderCtrl.text = "ស្រី";
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
