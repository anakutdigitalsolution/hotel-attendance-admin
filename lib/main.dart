import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/route_generator.dart';
import 'package:hotle_attendnce_admin/src/feature/account/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/department_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/language/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/bloc/leave_type_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/position/bloc/position_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/timetable_bloc.dart';

import 'src/feature/employee_timetable/bloc/index.dart';
import 'src/feature/landing/landing_page.dart';

///Receive message when app is in background solution for on message
// GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // // await Firebase.
  // SystemChrome.setEnabledSystemUIMode();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  //   // change status bar color
  // ));

  // await LocalNotificationService().initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // auth need initalize event because need to check auth for open the app
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) =>
                AuthenticationBloc()..add(CheckingAuthenticationStarted())),
        BlocProvider<LeaveBloc>(create: (BuildContext context) => LeaveBloc()),
        BlocProvider<LanguageBloc>(
            create: (BuildContext context) =>
                LanguageBloc()..add(LanguageLoadStarted())),
        BlocProvider<AccountBloc>(
            create: (BuildContext context) =>
                AccountBloc()..add(FetchAccountStarted())),
        BlocProvider<CheckInOutBloc>(
            create: (BuildContext context) => CheckInOutBloc()),
        BlocProvider<DepartmentBlc>(
            create: (BuildContext context) => DepartmentBlc()),
        BlocProvider<NotificationBloc>(
            create: (BuildContext context) => NotificationBloc()),
        BlocProvider<EmployeeBloc>(
            create: (BuildContext context) => EmployeeBloc()),
        BlocProvider<PositionBlc>(
            create: (BuildContext context) => PositionBlc()),
        BlocProvider<TimetableBloc>(
            create: (BuildContext context) => TimetableBloc()),
        BlocProvider<EmployeeBloc>(
            create: (BuildContext context) => EmployeeBloc()),
        BlocProvider<EmployeeTimetableBloc>(
            create: (BuildContext context) => EmployeeTimetableBloc()),
        BlocProvider<LeaveTypeBloc>(
            create: (BuildContext context) => LeaveTypeBloc()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state.locale,
            onGenerateRoute: RouteGenerator.generateRoute,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              // AppLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', 'US'),
              Locale('km', 'KH'),
              // Locale('zh', 'CN'),
            ],
            debugShowCheckedModeBanner: false,
            title: 'Attendance Admin',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LandingPage(),
            builder: EasyLoading.init(),
            // routes: ,
            // initialRoute: '/',
            // routes: {
            //   '/': (context) => LandingPage(),
            //   '/push': (context) => PushCategoryNotificatin(),

            // },
          );
        },
      ),
    );
  }
}
