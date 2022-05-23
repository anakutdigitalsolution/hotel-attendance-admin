import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/department/screen/department_page.dart';

import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_event.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_state.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/screen/position_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:intl/intl.dart';

import 'employee_page.dart';

class EditEmployee extends StatefulWidget {
  final EmployeeModel employeeModel;
  const EditEmployee({required this.employeeModel});

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
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
  final TextEditingController _officeTelCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  File? _image;
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? dateToday;
  @override
  void initState() {
    _nameCtrl.text = widget.employeeModel.name;
    widget.employeeModel.address == null
        ? _addressCtrl.text = ""
        : _addressCtrl.text = widget.employeeModel.address!;
    _departmentIdCtrl.text = widget.employeeModel.departmentModel!.name!;
    _positionIdCtrl.text = widget.employeeModel.positionModel!.positionName;
    _genderCtrl.text = widget.employeeModel.gender;
    widget.employeeModel.phone == null
        ? _phoneNumberCtrl.text = ""
        : _phoneNumberCtrl.text = widget.employeeModel.phone!;
    _usernameCtrl.text = widget.employeeModel.username!;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    dateToday = formattedDate.toString();
    super.initState();
  }

  _dialogDate({required TextEditingController controller}) async {
    DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(2018, 01, 01),
            maxTime: DateTime(2030, 01, 01),
            theme: DatePickerTheme(
                headerColor: Colors.blueGrey,
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
      appBar: standardAppBar(context, "Edit Employee"),
      body: Builder(builder: (context) {
        return BlocListener(
            bloc: employeeBloc,
            listener: (context, state) {
              if (state is AddingEmployee) {
                EasyLoading.show(status: "loading...");
                // loadingDialogs(context);
              }
              if (state is ErorrAddingEmployee) {
                EasyLoading.dismiss();
                errorSnackBar(text: state.error.toString(), context: context);
              }
              if (state is AddedEmployee) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Sucess");
                // EasyLoading.dismiss();
                Navigator.pop(context);

                print("success");
              }
            },
            child: BlocListener(
              bloc: departmentBlc,
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
                                      Radius.circular(15.0),
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
                                      Radius.circular(15.0),
                                    ),
                                    borderSide: new BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  isDense: true,
                                  labelText: "Select gender"),
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
                              controller: _emailCtrl,
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
                                  labelText: "Email"),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _dobCtrl,
                              keyboardType: TextInputType.text,
                              onTap: () {
                                _dialogDate(controller: _dobCtrl);
                              },
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
                                  labelText: "Date of Birth"),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _usernameCtrl,
                              readOnly: true,
                              // keyboardType: TextInputType.text,
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
                                  labelText: "Username"),
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'Username is required';
                              //   }
                              //   return null;
                              // },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _officeTelCtrl,
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
                                  labelText: "Office Tel"),
                            ),
                            SizedBox(height: 15),
                            // TextFormField(
                            //   controller: _usernameCtrl,
                            //   keyboardType: TextInputType.text,
                            //   decoration: InputDecoration(
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
                            //       labelText: "Username"),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Username is required';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // SizedBox(height: 15),
                            // TextFormField(
                            //   controller: _passwordCtrl,
                            //   keyboardType: TextInputType.text,
                            //   decoration: InputDecoration(
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
                            //       labelText: "password"),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'password is required';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // SizedBox(height: 15),
                            TextFormField(
                              controller: _phoneNumberCtrl,
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
                                departmentBlc.add(FetchAllDepartmentStarted());
                              },
                              readOnly: true,
                              keyboardType: TextInputType.text,
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
                                  labelText: "select department name"),
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
                                  labelText: "select position name"),
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
                                      Radius.circular(15.0),
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
                            SizedBox(height: 15),
                            GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: Container(
                                    width: (MediaQuery.of(context).size.width /
                                            10) *
                                        8,
                                    child: (_image == null)
                                        ? widget.employeeModel.img == null
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
                                                        BorderRadius.circular(
                                                            5)),
                                                child: FittedBox(
                                                  fit: BoxFit.fill,
                                                  child: Icon(
                                                    Icons.add_a_photo_outlined,
                                                    color: Colors.grey[600],
                                                    size:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                10) *
                                                            3,
                                                  ),
                                                ),
                                              )
                                            : CachedNetworkImage(
                                                fit: BoxFit.fitWidth,
                                                // memCacheHeight: 250,
                                                // memCacheWidth: 250,
                                                imageUrl:
                                                    "https://banban-hr.herokuapp.com/${widget.employeeModel.img!}",
                                                errorWidget: (context, a, b) {
                                                  return FittedBox(
                                                      fit: BoxFit.fill,
                                                      child: Icon(
                                                        Icons
                                                            .add_a_photo_outlined,
                                                        color: Colors.grey[600],
                                                        size: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10) *
                                                            3,
                                                      ));
                                                },
                                              )
                                        : Container(
                                            // height: MediaQuery.of(context).size.width / 3,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    10) *
                                                7,
                                            child: Image.file(_image!)))),
                            SizedBox(height: 30),
                            standardBtn(
                                title: "Update",
                                onTap: () {
                                  String depart = "";
                                  String position = "";
                                  String url = "";
                                  if (_formKey!.currentState!.validate()) {
                                    if (_departmentIdCtrl.text !=
                                        widget.employeeModel.departmentModel!
                                            .name) {
                                      DepartmentModel departId = departmentBlc
                                          .departmentList
                                          .firstWhere((element) =>
                                              element.name ==
                                              _departmentIdCtrl.text);
                                      depart = departId.id;
                                    } else {
                                      depart = widget
                                          .employeeModel.departmentModel!.id;
                                    }
                                    if (_positionIdCtrl.text !=
                                        widget.employeeModel.positionModel!
                                            .positionName) {
                                      PositionModel posiId = positionBlc
                                          .positionList
                                          .firstWhere((element) =>
                                              element.positionName ==
                                              _positionIdCtrl.text);
                                      position = posiId.id;
                                    } else {
                                      position = widget
                                          .employeeModel.positionModel!.id;
                                    }
                                    if (widget.employeeModel.img == null) {
                                      url = "";
                                    } else {
                                      url = widget.employeeModel.img!;
                                    }

                                    employeeBloc.add(UpdateEmployeeStarted(
                                        id: widget.employeeModel.id,
                                        name: _nameCtrl.text,
                                        gender: _genderCtrl.text,
                                        dob: _dobCtrl.text,
                                        email: _emailCtrl.text,
                                        officeTel: _officeTelCtrl.text,
                                        // username: _usernameCtrl.text,
                                        img: _image,
                                        imgUrl: url,
                                        // password: _passwordCtrl.text,
                                        positionId: position,
                                        departmentId: depart,
                                        // storeId: "1",
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
              ),
            ));
      }),
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
