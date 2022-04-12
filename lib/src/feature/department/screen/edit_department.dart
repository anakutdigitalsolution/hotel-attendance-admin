import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
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
  final TextEditingController _reasonCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _reasonCtrl.text = widget.departmentModel.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Edit Department"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: departmentBlc,
          listener: (context, state) {
            if (state is AddingDepartment) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingDepartment) {
              Navigator.pop(context);
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedDepartment) {
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
                      SizedBox(height: MediaQuery.of(context).size.height/4),
                       standardBtn(title: "Update",onTap: (){
                         if (_formKey!.currentState!.validate()) {
                                departmentBlc.add(UpdateDepartmentStarted(
                                    id: widget.departmentModel.id,
                                    name: _reasonCtrl.text));
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
