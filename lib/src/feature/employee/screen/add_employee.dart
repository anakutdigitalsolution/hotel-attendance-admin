import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/department/screen/department_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_event.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_state.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/role_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/screen/position_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'employee_page.dart';

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

  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _officeTelCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _positionIdCtrl = TextEditingController();
  final TextEditingController _departmentIdCtrl = TextEditingController();
  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _roleCtrl = TextEditingController();
  final TextEditingController _statusCtl = TextEditingController();
  final TextEditingController _coupleCtrl = TextEditingController();
  final TextEditingController _numchildCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  File? _image;
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? dateToday;
  List<String> gender = ["Female", "Male", "Other"];
  List<String> status = ["married", "single"];
  List<String> job = ["housewife", "not housewife"];
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    dateToday = formattedDate.toString();
    super.initState();
  }

  _dialogDate({required TextEditingController controller}) async {
    DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(DateTime.now().year - 50),
            maxTime: DateTime(DateTime.now().year + 60),
            theme: DatePickerTheme(
                headerColor: Colors.blue,
                backgroundColor: Colors.white,
                itemStyle: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
                doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
            onChanged: (date) {},
            onConfirm: (date) {},
            currentTime: DateTime.now(),
            locale: LocaleType.en)
        .then((value) {
      setState(() {
        date = value;
        String formateDate = DateFormat('yyyy/MM/dd').format(date!);
        controller.text = formateDate.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context, "Add Employee"),
      body: Builder(builder: (context) {
        return BlocListener(
            bloc: employeeBloc,
            listener: (context, state) {
              if (state is AddingEmployee) {
                EasyLoading.show(status: "loading....");
              }
              if (state is ErorrAddingEmployee) {
                EasyLoading.dismiss();
                errorSnackBar(text: state.error.toString(), context: context);
              }
              if (state is AddedEmployee) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Sucess");
                Navigator.pop(context);
              }
            },
            child: BlocListener(
              bloc: departmentBlc,
              listener: (context, state) {
                if (state is FetchingDepartment) {
                  EasyLoading.show(status: "loading...");
                }
                if (state is ErrorFetchingDepartment) {
                  EasyLoading.dismiss();
                  errorSnackBar(text: state.error.toString(), context: context);
                }
                if (state is FetchedDepartment) {
                  EasyLoading.dismiss();
                  customModal(context,
                      departmentBlc.departmentList.map((e) => e.name!).toList(),
                      (value) {
                    _departmentIdCtrl.text = value;
                    // roomTypeModel = BlocProvider.of<RoomTypeBloc>(context)
                    //     .roomtype
                    //     .firstWhere((roomtype) => roomtype.type == value);
                    // _roomNumberCtrl.clear();
                    // _stayingCtrl.clear();
                  });
                }
              },
              child: BlocListener(
                  bloc: positionBlc,
                  listener: (context, state) {
                    if (state is FetchingPosition) {
                      EasyLoading.show(status: "loading...");
                    }
                    if (state is ErrorFetchingPosition) {
                      EasyLoading.dismiss();
                      errorSnackBar(
                          text: state.error.toString(), context: context);
                    }
                    if (state is FetchedPosition) {
                      EasyLoading.dismiss();
                      customModal(
                          context,
                          positionBlc.positionList
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
                  child: BlocListener(
                    bloc: employeeBloc,
                    listener: (context, state) {
                      if (state is FetchingRole) {
                        EasyLoading.show(status: "loading...");
                      }
                      if (state is ErrorFetchingRole) {
                        EasyLoading.dismiss();
                        errorSnackBar(
                            text: state.error.toString(), context: context);
                      }
                      if (state is FetchedRole) {
                        EasyLoading.dismiss();
                        customModal(context,
                            employeeBloc.roleList.map((e) => e.name).toList(),
                            (value) {
                          _roleCtrl.text = value;
                        });
                      }
                    },
                    child: ListView(
                      children: [
                        Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                TextFormField(
                                  // controller: code,
                                  controller: _nameCtrl,
                                  decoration: InputDecoration(
                                      labelText: "Enter full name",
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      // isDense: true,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      )
                                      ),

                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Full name is required';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: 15),
                                TextFormField(
                                  // controller: code,
                                  controller: _genderCtrl,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.arrow_drop_down),
                                      labelText: "Choose gender",
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      )),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Gender is required';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    customModal(context, gender, (value) {
                                      _genderCtrl.text = value;
                                    });
                                  },
                                  readOnly: true,
                                ),
                                // TextFormField(
                                //   controller: _genderCtrl,
                                //   keyboardType: TextInputType.text,
                                //   decoration: InputDecoration(
                                //       suffixIcon: Icon(Icons.arrow_drop_down),
                                //       contentPadding: EdgeInsets.all(15),
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.all(
                                //           Radius.circular(5.0),
                                //         ),
                                //         borderSide: new BorderSide(
                                //           width: 1,
                                //         ),
                                //       ),
                                //       isDense: true,
                                //       labelText: "Choose gender"),
                                //   onTap: () {
                                //     customModal(context, gender, (value) {
                                //       _genderCtrl.text = value;
                                //     });
                                //   },
                                //   readOnly: true,
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return 'Please select gender';
                                //     }
                                //     return null;
                                //   },
                                // ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _dobCtrl,
                                  keyboardType: TextInputType.text,
                                  onTap: () {
                                    _dialogDate(controller: _dobCtrl);
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      labelText: "Date of Birth"),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _emailCtrl,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      labelText: "Enter email address"),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _usernameCtrl,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
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
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
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
                                  controller: _officeTelCtrl,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      labelText: "Office Tel"),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _phoneNumberCtrl,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      labelText: "Phone number"),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _departmentIdCtrl,
                                  onTap: () {
                                    departmentBlc
                                        .add(FetchAllDepartmentStarted());
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.arrow_drop_down),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      labelText: "Choose deparment"),
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
                                    positionBlc.add(FetchAllPositionStarted());
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.arrow_drop_down),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      labelText: "Choose position"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'position is required';
                                    }
                                    return null;
                                  },
                                ),
                                // SizedBox(height: 15),
                                // TextFormField(
                                //   controller: _roleCtrl,
                                //   onTap: () {
                                //     employeeBloc.add(FetchRoleStarted());
                                //   },
                                //   readOnly: true,
                                //   keyboardType: TextInputType.text,
                                //   decoration: InputDecoration(
                                //       suffixIcon: Icon(Icons.arrow_drop_down),
                                //       contentPadding: EdgeInsets.all(15),
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.all(
                                //           Radius.circular(5.0),
                                //         ),
                                //         borderSide: new BorderSide(
                                //           width: 1,
                                //         ),
                                //       ),
                                //       isDense: true,
                                //       labelText: "select role "),
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return 'role is required';
                                //     }
                                //     return null;
                                //   },
                                // ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _addressCtrl,
                                  keyboardType: TextInputType.text,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      labelText: "Enter address"),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _statusCtl,
                                  onTap: () {
                                    customModal(context, status, (value) {
                                      _statusCtl.text = value;
                                    });
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.arrow_drop_down),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      labelText: "Choose merital status"),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _coupleCtrl,
                                  onTap: () {
                                    customModal(context, job, (value) {
                                      _coupleCtrl.text = value;
                                    });
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.arrow_drop_down),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      labelText: "Choose couple job"),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _numchildCtrl,
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      labelText: "Enter number of children"),
                                ),
                                SizedBox(height: 15),
                                GestureDetector(
                                    onTap: () {
                                      _showPicker(context);
                                    },
                                    child: (_image == null)
                                        ? Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    10) *
                                                4,
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    10) *
                                                4,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Icon(
                                                Icons.add_a_photo_outlined,
                                                color: Colors.grey[600],
                                                size: (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        10) *
                                                    3,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            // height: MediaQuery.of(context).size.width / 3,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    10) *
                                                7,
                                            child: Image.file(_image!))),
                                SizedBox(height: 30),
                                standardBtn(
                                    title: "Submit",
                                    onTap: () {
                                      if (_formKey!.currentState!.validate()) {
                                        DepartmentModel departId = departmentBlc
                                            .departmentList
                                            .firstWhere((element) =>
                                                element.name ==
                                                _departmentIdCtrl.text);

                                        PositionModel posiId = positionBlc
                                            .positionList
                                            .firstWhere((element) =>
                                                element.positionName ==
                                                _positionIdCtrl.text);
                                        // RoleModel roleModel = employeeBloc
                                        //     .roleList
                                        //     .firstWhere((e) =>
                                        //         e.name == _roleCtrl.text);
                                        if (_image == null) {}
                                        print(_image);
                                        employeeBloc.add(AddEmployeeStarted(
                                            // roleId: roleModel.id,
                                            name: _nameCtrl.text,
                                            gender: _genderCtrl.text,
                                            dob: _dobCtrl.text,
                                            email: _emailCtrl.text,
                                            username: _usernameCtrl.text,
                                            img: _image,
                                            password: _passwordCtrl.text,
                                            positionId: posiId.id,
                                            departmentId: departId.id,
                                            meritalStatus: _statusCtl.text,
                                            coupleJob: _coupleCtrl.text,
                                            child: _numchildCtrl.text,
                                            officeTel: _officeTelCtrl.text,
                                            phoneNumber: _phoneNumberCtrl.text,
                                            address: _addressCtrl.text));
                                      }
                                    })
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ));
      }),
      // bottomNavigationBar:
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        // _imgFromGallery();
                        Helper.imgFromGallery((image) {
                          setState(() {
                            _image = image;
                          });
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Helper.imgFromCamera((image) {
                        setState(() {
                          _image = image;
                        });
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
                      title: new Text("???????????????"),
                      onTap: () {
                        _genderCtrl.text = "???????????????";
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    title: new Text("????????????"),
                    onTap: () {
                      _genderCtrl.text = "????????????";
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
