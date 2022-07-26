import 'package:hotle_attendnce_admin/src/feature/account/screen/account_page_one.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/screen/attendance_employee_page.dart';

import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/department/screen/add_department.dart';
import 'package:hotle_attendnce_admin/src/feature/department/screen/department_page.dart';
import 'package:hotle_attendnce_admin/src/feature/department/screen/edit_department.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/add_employee.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/admin_reset_password.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/employee_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/reset_password.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/model/employee_timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/screen/add_schedule.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/screen/edit_schedule.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/screen/schedule_page_employee.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/screen/shedule_page.dart';
import 'package:hotle_attendnce_admin/src/feature/group/model/group_model.dart';
import 'package:hotle_attendnce_admin/src/feature/group/screen/add_group.dart';
import 'package:hotle_attendnce_admin/src/feature/group/screen/edit_group.dart';
import 'package:hotle_attendnce_admin/src/feature/group/screen/group_page.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/screen/add_holiday.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/screen/holiday_page.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/screen/add_leave_type.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/screen/leave_type_page.dart';
import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';
import 'package:hotle_attendnce_admin/src/feature/location/screens/add_location.dart';
import 'package:hotle_attendnce_admin/src/feature/location/screens/edit_location.dart';
import 'package:hotle_attendnce_admin/src/feature/location/screens/location_page.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/screen/add_notification.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/screen/notification_page.dart';
import 'package:hotle_attendnce_admin/src/feature/overtime/model/overtime_model.dart';
import 'package:hotle_attendnce_admin/src/feature/overtime/screen/add_overtime.dart';
import 'package:hotle_attendnce_admin/src/feature/overtime/screen/edit_overtime.dart';
import 'package:hotle_attendnce_admin/src/feature/overtime/screen/overtime_page.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/screen/payslip_page.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/screen/leave_page.dart';
import 'package:hotle_attendnce_admin/src/feature/position/screen/add_position.dart';
import 'package:hotle_attendnce_admin/src/feature/position/screen/position_page.dart';
import 'package:hotle_attendnce_admin/src/feature/qrcode/screen/qr_page.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/report_page.dart';
import 'package:hotle_attendnce_admin/src/feature/setting/screen/operation_page.dart';
import 'package:hotle_attendnce_admin/src/feature/setting/screen/setting_page_one.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/screen/add_timetable.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/screen/timetable_page.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/screen/add_working_day.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/screen/edit_working_day.dart';
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
      // case account:
      //   return MaterialPageRoute(builder: (_) => AccountPage());
      case setting:
        return MaterialPageRoute(builder: (_) => SettingPage());
      case department:
        return MaterialPageRoute(builder: (_) => DepartmentPage());
      case operation:
        return MaterialPageRoute(builder: (_) => OperationPage());
      case employee:
        return MaterialPageRoute(builder: (_) => EmployeePage());
      case position:
        return MaterialPageRoute(builder: (_) => PositionPage());
      case timetable:
        return MaterialPageRoute(builder: (_) => TimetablePage());
      case payslip:
        return MaterialPageRoute(builder: (_) => PaySlippage());
      // case add:
      //   return MaterialPageRoute(builder: (_) => SchedulePage());
      case schedules:
        return MaterialPageRoute(builder: (_) => ScheduleEmployeePage());
      case leave:
        return MaterialPageRoute(builder: (_) => LeavePage());
      case leavetype:
        return MaterialPageRoute(builder: (_) => LeaveTypePage());

      case holiday:
        return MaterialPageRoute(builder: (_) => HolidayPage());
      case qr:
        return MaterialPageRoute(builder: (_) => QRPage());
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
      case addWorkingday:
        return MaterialPageRoute(builder: (_) => AddWorkingDay());
      case group:
        return MaterialPageRoute(builder: (_) => GroupPage());
      case addGroup:
        return MaterialPageRoute(builder: (_) => AddGroup());
      case editGroup:
        if (args is GroupModel) {
          return MaterialPageRoute(
              builder: (_) => EditGroup(
                    groupModel: args,
                  ));
        }
        return _errorRoute();
      case editWorkingday:
        if (args is WorkingDayModel) {
          return MaterialPageRoute(
              builder: (_) => EditWorkingDay(
                    workingDayModel: args,
                  ));
        }
        return _errorRoute();
      case editDepartment:
        if (args is DepartmentModel) {
          return MaterialPageRoute(
              builder: (_) => EditDepartment(
                    departmentModel: args,
                  ));
        }
        return _errorRoute();
      case location:
        return MaterialPageRoute(builder: (_) => LocationPage());
      case addLocation:
        return MaterialPageRoute(builder: (_) => AddLocation());
      case resetpassword:
        return MaterialPageRoute(builder: (_) => AdminResetPassword());
       case overtime:
        return MaterialPageRoute(builder: (_) => Overtimepage());
      case addOvertime:
       return MaterialPageRoute(builder: (_) => AddOvertime());
      case editLocation:
        if (args is LocationModel) {
          return MaterialPageRoute(
              builder: (_) => EditLocation(
                    locationModel: args,
                  ));
        }
        return _errorRoute();
      case editOvertime:
        if (args is OvertimeModel) {
          return MaterialPageRoute(
              builder: (_) => EditOvertime(
                    overtimeModel: args,
                  ));
        }
        return _errorRoute();
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
