import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/location/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/location/bloc/location_state.dart';
import 'package:hotle_attendnce_admin/src/feature/location/screens/location_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import 'widgets/lat_long.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _latCtrl = TextEditingController();
  final TextEditingController _lonCtrl = TextEditingController();
  final TextEditingController _desCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, " Add Location QR"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: locationBloc,
          listener: (context, state) {
            if (state is AddingLocation) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingLocation) {
              EasyLoading.dismiss();
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedLocation) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Sucess");
              Navigator.pop(context);
            }
          },
          child: ListView(
            children: [
              LatLong(),
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
                        keyboardType: TextInputType.number,
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
                            labelText: "Latitude "),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Latitude  is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _lonCtrl,
                        keyboardType: TextInputType.number,
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
                            labelText: "Longtitude is required"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Longtitude is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _desCtrl,
                        maxLines: null,
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
                        maxLines: null,
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
                        //     return 'Off duty';
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: 30),

                      // SizedBox(height: MediaQuery.of(context).size.height / 5),
                      standardBtn(
                          title: "Submit",
                          onTap: () {
                            if (_formKey!.currentState!.validate()) {
                              locationBloc.add(AddLocationStarted(
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
