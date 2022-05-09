import 'package:hotle_attendnce_admin/src/feature/account/screen/account_page_one.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/screen/attendance_employee_page.dart';

import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/feature/department/screen/add_department.dart';
import 'package:hotle_attendnce_admin/src/feature/department/screen/department_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/add_employee.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/employee_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/model/employee_timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/screen/add_schedule.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/screen/edit_schedule.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/screen/schedule_page_employee.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/screen/shedule_page.dart';
import 'package:hotle_attendnce_admin/src/feature/group/screen/group_page.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/screen/add_holiday.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/screen/holiday_page.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/screen/add_leave_type.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/screen/leave_type_page.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/screen/add_notification.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/screen/notification_page.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/screen/leave_page.dart';
import 'package:hotle_attendnce_admin/src/feature/position/screen/add_position.dart';
import 'package:hotle_attendnce_admin/src/feature/position/screen/position_page.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/report_page.dart';
import 'package:hotle_attendnce_admin/src/feature/setting/screen/setting_page.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/screen/add_timetable.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/screen/timetable_page.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/screen/working_day.dart';

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
       case schedules:
        return MaterialPageRoute(builder: (_) => ScheduleEmployeePage());
      case leave:
        return MaterialPageRoute(builder: (_) => LeavePage());
      case leavetype:
        return MaterialPageRoute(builder: (_) => LeaveTypePage());

      case holiday:
        return MaterialPageRoute(builder: (_) => HolidayPage());
      case addHoliday:
        return MaterialPageRoute(builder: (_) => AddHoliday());

      case report:
        return MaterialPageRoute(builder: (_) => ReportPage());
      case notification:
        return MaterialPageRoute(builder: (_) => NotificationPage());
      case addNotification:
        return MaterialPageRoute(builder: (_) => AddNotification());
      case addDepartment:
        return MaterialPageRoute(builder: (_) => AddDepartment());
      case addPosition:
        return MaterialPageRoute(builder: (_) => AddPosition());
      case addTimetable:
        return MaterialPageRoute(builder: (_) => AddTimetable());
      case addLeavetype:
        return MaterialPageRoute(builder: (_) => AddLeaveType());
      case addEmployee:
        return MaterialPageRoute(builder: (_) => AddEmployee());
      case addschedule:
        return MaterialPageRoute(builder: (_) => AddSchedule());
      case editschedule:
        if (args is EmployeeTimetablModel) {
          return MaterialPageRoute(
              builder: (_) => EditSchedule(employeeTimetablModel: args));
        }
        return _errorRoute();
      case workDay:
        return MaterialPageRoute(builder: (_) => WorkingDay());
       case group:
        return MaterialPageRoute(builder: (_) => GroupPage());
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
