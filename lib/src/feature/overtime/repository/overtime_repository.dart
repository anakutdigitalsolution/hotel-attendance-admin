import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/overtime/model/overtime_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';


class OvertimerRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider _apiProvider = ApiProvider();
  // for specific user
  Future<List<OvertimeModel>> getOvertime(
      {required String startDate,
      required String endDate,
      required int rowperpage,
      required int page}) async {
    try {
      String url = mainUrl +
          "me/overtimes?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";

      Response response = await _apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<OvertimeModel> leave = [];
        response.data["data"].forEach((data) {
          // leave.add(OvertimeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  // user edit status accept or not , and
  // if accept , return cash or holiday instead
  Future<void> editStatusOvertime(
      {required String id,
      required String status,
      required String type,
      }) async {
    try {
      String url = mainUrl + "me/overtimes/edit/$id";
      Map body = {};
      Response response = await _apiProvider.put(url, body);
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

  // for chief role
  Future<List<OvertimeModel>> getAllOvertime({
    required int rowperpage,
    required int page,
    required String startDate,
    required String endDate,
  }) async {
    try {
      String url = mainUrl +
          "overtimes/chief?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
     

      Response response = await _apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<OvertimeModel> leave = [];
        response.data["data"].forEach((data) {
          // leave.add(OvertimeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addOvertime(
      {required String userId,
      required String reason,
      required String duration,
      required String fromDate,
      required String notes,
      required String toDate}) async {
    try {
      String url = mainUrl + "overtimes/chief/add";
      Map body = {};
      Response response = await _apiProvider.post(url, body, null);

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

  Future<void> editOvertime(
      {required String id,
      required String userId,
      required String reason,
      required String duration,
      required String fromDate,
      required String notes,
      required String toDate}) async {
    try {
      String url = mainUrl + "overtimes/chief/edit/$id";
      Map body = {};
      Response response = await _apiProvider.put(url, body);
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

  Future<void> deleteOvertime({
    required String id,
  }) async {
    try {
      String url = mainUrl + "overtimes/chief/delete/$id";

      Response response = await _apiProvider.delete(url, null);
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
