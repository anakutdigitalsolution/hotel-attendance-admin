import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/widget/employee_detail_tile.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class EmployeeDetailPage extends StatefulWidget {
  final EmployeeModel employeeModel;
  const EmployeeDetailPage({required this.employeeModel});

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Employee Detail"),
      body: Stack(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              // color: Colors.grey.withOpacity(0.2),
              child: Column(
                children: [
                  EmployeeDetailTile(employeeModel: widget.employeeModel)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
