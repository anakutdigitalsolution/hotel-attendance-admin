import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/position/bloc/index.dart';

import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import 'position_page.dart';

class AddPosition extends StatefulWidget {
  const AddPosition({Key? key}) : super(key: key);

  @override
  State<AddPosition> createState() => _AddPositionState();
}

class _AddPositionState extends State<AddPosition> {
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _typeCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Add Position"),
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
                      standardBtn(title: "Submit",onTap: (){
                         if (_formKey!.currentState!.validate()) {
                                positionBlc.add(AddPositionStarted(
                                    name: _reasonCtrl.text,
                                    type: _typeCtrl.text));
                              }
                      })
                      // Container(
                      //   margin:
                      //       EdgeInsets.only(left: 30, right: 30, bottom: 10),
                      //   height: 50,
                      //   width: double.infinity,
                      //   child: FlatButton(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(20),
                      //         // side: BorderSide(color: Colors.red)
                      //       ),
                      //       color: Colors.blue,
                      //       onPressed: () {
                             
                      //       },
                      //       padding: EdgeInsets.symmetric(vertical: 10),
                      //       child: Text(
                      //         "Submit",
                      //         // AppLocalizations.of(context)!.translate("submit")!,
                      //         textScaleFactor: 1.2,
                      //         style: TextStyle(color: Colors.white),
                      //       )),
                      // ),
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
