
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/appLocalizations.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/overtime/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/overtime/model/overtime_model.dart';
import 'package:hotle_attendnce_admin/src/feature/overtime/screen/overtime_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:intl/intl.dart';

class EditOvertime extends StatefulWidget {
  final OvertimeModel overtimeModel;
  const EditOvertime({required this.overtimeModel});

  @override
  State<EditOvertime> createState() => _EditOvertimeState();
}

class _EditOvertimeState extends State<EditOvertime> {
  final TextEditingController _usrCtrl = TextEditingController();
  final TextEditingController _fromCtrl = TextEditingController();
  final TextEditingController _toCtrl = TextEditingController();
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _numCtrl = TextEditingController();
  final TextEditingController? _subtypeCtrl = TextEditingController();
  final TextEditingController _typeCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();

  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  EmployeeBloc _employeeBloc = EmployeeBloc();
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? dateToday;
  String id = "";

  List<String> typeList = [
    'hour',
    'day',
  ];
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    dateToday = formattedDate.toString();
    _usrCtrl.text = widget.overtimeModel.employeeModel!.name;
    _reasonCtrl.text = widget.overtimeModel.reason!;
    _typeCtrl.text = widget.overtimeModel.type!;
    _fromCtrl.text = widget.overtimeModel.fromDate!;
    _toCtrl.text = widget.overtimeModel.toDate!;
    _numCtrl.text = widget.overtimeModel.duration!;
    widget.overtimeModel.notes == null
        ? _noteCtrl.text = ""
        : _noteCtrl.text = widget.overtimeModel.notes!;
    super.initState();
  }

  _dialogDate({required TextEditingController controller}) async {
    DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(DateTime.now().year - 5),
            maxTime: DateTime(DateTime.now().year + 60),
            // minTime: DateTime(2018, 01, 01),
            // maxTime: DateTime(2030, 01, 01),
            theme: DatePickerTheme(
                // headerColor: Colors.blueGrey,
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
      if (value == null) {
        print("null");
      } else {
        setState(() {
          date = value;
          String formateDate = DateFormat('yyyy/MM/dd').format(date!);
          controller.text = formateDate.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("edit_ot")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: overtimeBloc,
          listener: (context, state) {
            if (state is AddingOvertime) {
              EasyLoading.show(status: 'loading...');
            }
            if (state is ErrorAddingOvertime) {
              EasyLoading.dismiss();
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedOvertime) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Success');
              Navigator.pop(context);
              print("success");
            }
          },
          child: BlocListener(
              bloc: _employeeBloc,
              listener: (context, state) {
                if (state is FetchingEmployee) {
                  EasyLoading.show(status: 'loading');
                }
                if (state is ErrorFetchingEmployee) {
                  EasyLoading.dismiss();
                  errorSnackBar(text: state.error.toString(), context: context);
                }
                if (state is FetchedEmployee) {
                  EasyLoading.dismiss();

                  customModal(context,
                      _employeeBloc.emploList.map((e) => e.name).toList(),
                      (value) {
                    _usrCtrl.text = value;
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
                          TextFormField(
                            controller: _typeCtrl,
                            onTap: () {
                              customModal(context, typeList, (value) {
                                _typeCtrl.text = value;
                                print(value);
                              });
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
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("type")!}"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'type  is required.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _usrCtrl,
                            onTap: () {
                              _employeeBloc
                                  .add(FetchAllEmployeeStarted());
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
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("choose_username")!}"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'user name is required.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _reasonCtrl,
                            keyboardType: TextInputType.text,
                            maxLines: null,
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
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("reason")!}"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Reason is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _numCtrl,
                            keyboardType: TextInputType.number,
                            // keyboardType: TextInputType.multiline,
                            // minLines: 5,
                            // maxLines: 20,
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
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("duration")!}"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Duration is required.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _fromCtrl,
                            readOnly: true,
                            // keyboardType: TextInputType.text,
                            onTap: () {
                              _dialogDate(controller: _fromCtrl);
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.lightBlue,
                                ),
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
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("from_date")!}"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'From date is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _toCtrl,
                            // keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap: () {
                              _dialogDate(controller: _toCtrl);
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.lightBlue,
                                ),
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
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("to_date")!}"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'To Date is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _noteCtrl,
                            keyboardType: TextInputType.text,
                            maxLines: null,
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
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("notes")!}"),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 10),
                          Container(
                            margin: EdgeInsets.only(
                                left: 30, right: 30, bottom: 10),
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
                                    String user = "";
                                    // addessdetail = 11.565271/94.6778 so we need to spilt into lat and long
                                    if (_usrCtrl.text !=
                                        widget.overtimeModel.employeeModel!.name) {
                                      EmployeeModel userModel = _employeeBloc
                                          .emploList
                                          .firstWhere((element) =>
                                              element.name == _usrCtrl.text);

                                      user = userModel.id;
                                    } else {
                                      user = widget.overtimeModel.userId!;
                                    }

                                    overtimeBloc.add(UpdateOvertimeStarted(
                                        id: widget.overtimeModel.id,
                                        type: _typeCtrl.text,
                                        userId: user,
                                        fromDate: _fromCtrl.text,
                                        toDate: _toCtrl.text,
                                        notes: _noteCtrl.text,
                                        reason: _reasonCtrl.text,
                                        duration: _numCtrl.text));
                                  }
                                },
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "${AppLocalizations.of(context)!.translate("submit")!}",
                                  // AppLocalizations.of(context)!.translate("submit")!,
                                  textScaleFactor: 1.2,
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        );
      }),
    );
  }

  // void _showPicker(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     leading: new Icon(Icons.photo_library),
  //                     title: new Text('Photo Library'),
  //                     onTap: () {
  //                       // _imgFromGallery();
  //                       Helper.imgFromGallery((image) {
  //                         setState(() {
  //                           _image = image;
  //                         });
  //                       });
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   leading: new Icon(Icons.photo_camera),
  //                   title: new Text('Camera'),
  //                   onTap: () {
  //                     Helper.imgFromCamera((image) {
  //                       setState(() {
  //                         _image = image;
  //                       });
  //                     });
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
}
