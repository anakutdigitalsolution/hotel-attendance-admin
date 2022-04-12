import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import 'position_page.dart';

class EditPosition extends StatefulWidget {
  final PositionModel positionModel;
  const EditPosition({required this.positionModel});

  @override
  State<EditPosition> createState() => _EditPositionState();
}

class _EditPositionState extends State<EditPosition> {
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _typeCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _reasonCtrl.text = widget.positionModel.positionName;
    _typeCtrl.text = widget.positionModel.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Edit Position"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: positionBlc,
          listener: (context, state) {
            if (state is AddingPosition) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingPosition) {
              Navigator.pop(context);
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedPosition) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Sucess");
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
                                Radius.circular(15.0),
                              ),
                              borderSide: new BorderSide(
                                width: 1,
                              ),
                            ),
                            isDense: true,
                            labelText: "Position name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Type name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _typeCtrl,
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
                            labelText: "Type "),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'type';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 4),
                       standardBtn(title: "Update",onTap: (){
                        if (_formKey!.currentState!.validate()) {
                                positionBlc.add(UpdatePositionStarted(
                                    id: widget.positionModel.id,
                                    name: _reasonCtrl.text,
                                    type: _typeCtrl.text));
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
