import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class DepartmentRepository {
  String mainUrl = "http://my-attendance-test-demo.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<DepartmentModel>> getdepartment(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "department?page_size=$rowPerpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<DepartmentModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(DepartmentModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addDepartment({
    required String name,
  }) async {
    try {
      String url = mainUrl + "department/add";
      Map body = {
        "department_name": name,
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

  Future<void> editDepartment({
    required String id,
    required String name,
  }) async {
    try {
      String url = mainUrl + "department/edit/$id";
      Map body = {
        "department_name": name,
      };
      Response response = await apiProvider.put(url, body);

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

  Future<void> deleteDepartment({
    required String id,
  }) async {
    try {
      String url = mainUrl + "department/delete/$id";

      Response response = await apiProvider.delete(url, null);
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
