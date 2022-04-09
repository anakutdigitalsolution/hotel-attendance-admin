import 'package:hotle_attendnce_admin/src/feature/account/screen/account_page_one.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/screen/attendance_employee_page.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/screen/attendance_page.dart';
import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/feature/department/screen/department_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/employee_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/screen/shedule_page.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/screen/add_holiday.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/screen/holiday_page.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/screen/leave_type_page.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/screen/leave_page.dart';
import 'package:hotle_attendnce_admin/src/feature/position/screen/position_page.dart';
import 'package:hotle_attendnce_admin/src/feature/setting/screen/setting_page.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/screen/timetable_page.dart';

import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case attendance:
        return MaterialPageRoute(builder: (_) => AttendanceEmployeePage());
      // case saleReport:
      //   return MaterialPageRoute(builder: (_) => SaleReportPage());
      case account:
        return MaterialPageRoute(builder: (_) => AccountPage());
      case setting:
        return MaterialPageRoute(builder: (_) => SettingPage());
      case department:
        return MaterialPageRoute(builder: (_) => DepartmentPage());
      case employee:
        return MaterialPageRoute(builder: (_) => EmployeePage());
      case position:
        return MaterialPageRoute(builder: (_) => PositionPage());
      case timetable:
        return MaterialPageRoute(builder: (_) => TimetablePage());
      case schedule:
        return MaterialPageRoute(builder: (_) => SchedulePage());
      case leave:
        return MaterialPageRoute(builder: (_) => LeavePage());
      case leavetype:
        return MaterialPageRoute(builder: (_) => LeaveTypePage());
      case holiday:
        return MaterialPageRoute(builder: (_) => HolidayPage());
      case addHoliday:
        return MaterialPageRoute(builder: (_) => AddHoliday());

      // case editProduct:
      //   if (args is Product) {
      //     return MaterialPageRoute(
      //         builder: (_) => EditProductPage(
      //               product: args,
      //             ));
      //   }
      //   return _errorRoute();
      // case editCustomer:
      //   if (args is Customer) {
      //     return MaterialPageRoute(
      //         builder: (_) => EditCustomerPage(
      //               customer: args,
      //             ));
      //   }
      //   return _errorRoute();
      // case editCategory:
      //   if (args is Category) {
      //     return MaterialPageRoute(
      //         builder: (_) => EditCategoryPage(
      //               category: args,
      //             ));
      //   }
      //   return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
