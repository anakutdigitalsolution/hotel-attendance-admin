import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/model/checkin_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class CheckInOutRepository {
  ApiProvider apiProvider = ApiProvider();
  // String mainUrl = "http://10.0.2.2:8000/api/";
  String mainUrl = "http://my-attendance-test-demo.herokuapp.com/api/";
  Future<List<CheckinModel>> getcheckin(
      {required int page, required int rowperpage}) async {
    try {
      String url = mainUrl + "me/attendance?page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<CheckinModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(CheckinModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> checkin(
      {required String checkinTime, required String employeeId}) async {
    try {
      String url = mainUrl + "checkin/add";
      Map body = {
        // "type": "company",
        "checkin_time": checkinTime,
        "employee_id": employeeId,
        // "timetable_id": timetableId
      };

      Response response = await apiProvider.post(url, body, null);

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> checkout(
      {required String id,
      required String checkoutTime,
      required String employeeId}) async {
    try {
      String url = mainUrl + "checkout/edit/$id";
      Map body = {
        // "type": "company",
        "checkout_time": checkoutTime,
        "employee_id": employeeId,

        // "timetable_id": timetableId
      };

      Response response = await apiProvider.post(url, body, null);

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
