import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/model/employee_timetable_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class EmployeeTimetableRepository {
  String mainUrl = "http://my-attendance-test-demo.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<EmployeeTimetablModel>> getEmployee(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "schedules";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<EmployeeTimetablModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(EmployeeTimetablModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
