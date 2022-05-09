import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/group/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/group/screen/group_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class AddGroup extends StatelessWidget {
  const AddGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  final TextEditingController _workdayCtrl = TextEditingController();


  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: standardAppBar(context, "Add Group department"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: groupBloc,
          listener: (context,state){
            if (state is AddingGroup) {
                EasyLoading.show(status: 'loading...');
              }
              if (state is ErrorAddingGroup) {
                EasyLoading.dismiss();
                EasyLoading.showError(state.error.toString());
              }
              if (state is AddedGroup) {
                // BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Success");
                Navigator.pop(context);

                print("success");
              }
        },child: BlocListener(listener: (context,state){
          
        },child: ListView(
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
                                  labelText: "Name"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'name is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _workdayCtrl,
                              onTap: () {
                                // BlocProvider.of<EmployeeBloc>(context)
                                //     .add(FetchAllEmployeeStarted());
                              },
                              readOnly: true,
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
                                  labelText: "Choose Employee"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Employee is required.';
                                }
                                return null;
                              },
                            ),
                            
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _noteCtrl,
                              keyboardType: TextInputType.text,
                              // keyboardType: TextInputType.multiline,
                              // minLines: 5,
                              // maxLines: 20,
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
                              //     return 'Duration is required.';
                              //   }
                              //   return null;
                              // },
                            ),
                            SizedBox(height: 15),
                            
                            
                          ],
                        ),
                      ),
                    )
                  ],
                ),),);
      }),
    );
  }
}
