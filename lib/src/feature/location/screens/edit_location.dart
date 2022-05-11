import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/location/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';
import 'package:hotle_attendnce_admin/src/feature/location/screens/location_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

class EditLocation extends StatefulWidget {
  final LocationModel locationModel;
  const EditLocation({required this.locationModel});

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _latCtrl = TextEditingController();
  final TextEditingController _lonCtrl = TextEditingController();
  final TextEditingController _desCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _nameCtrl.text = widget.locationModel.name!;
    _latCtrl.text = widget.locationModel.lat!;
    _lonCtrl.text = widget.locationModel.long!;
    widget.locationModel.notes == null
        ? _noteCtrl.text = ""
        : _noteCtrl.text = widget.locationModel.notes!;
    widget.locationModel.description == null
        ? _desCtrl.text = ""
        : _desCtrl.text = widget.locationModel.description!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, " Edit Location QR"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: locationBloc,
          listener: (context, state) {
            if (state is AddingLocation) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingLocation) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.error.toString());
            }
            if (state is AddedLocation) {
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
                            labelText: "Location name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'location  name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _latCtrl,
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
                            labelText: "Latitute "),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Latitute  is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _lonCtrl,
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
                            labelText: "Longtitute is required"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Longtitute is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _desCtrl,
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
                            labelText: "Address Details"),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Off duty';
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _noteCtrl,
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
                            labelText: "Notes"),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Off duty';
                        //   }
                        //   return null;
                        // },
                      ),
                      // SizedBox(height: 15),

                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      standardBtn(
                          title: "Update",
                          onTap: () {
                            if (_formKey!.currentState!.validate()) {
                              locationBloc.add(UpdateLocationStarted(
                                  id: widget.locationModel.id,
                                  name: _nameCtrl.text,
                                  lat: _latCtrl.text,
                                  lon: _lonCtrl.text,
                                  notes: _noteCtrl.text,
                                  addressDetail: _desCtrl.text));
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
