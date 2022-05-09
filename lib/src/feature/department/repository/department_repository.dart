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
      String url = mainUrl + "departments?page_size=$rowPerpage&page=$page";

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
  Future<List<DepartmentModel>> getdepartmentByGroup(
      {required int rowPerpage, required int page,required String id}) async {
    try {
      String url = mainUrl + "departments&group_id=$id?page_size=$rowPerpage&page=$page";

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

  Future<List<DepartmentModel>> getAlldepartment() async {
    try {
      String url = mainUrl + "departments";

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
    required String notes,
    required String groupId,
    required String locationId,
  }) async {
    try {
      String url = mainUrl + "departments/add";
      Map body = {
        "department_name": name,
        "group_department_id":groupId,
        "location_id":locationId,
        "notes":notes
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
     required String notes,
    required String groupId,
    required String locationId,
  }) async {
    try {
      String url = mainUrl + "departments/edit/$id";
      Map body = {
        "department_name": name,
        "group_department_id":groupId,
        "location_id":locationId,
        "notes":notes
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
      String url = mainUrl + "departments/delete/$id";

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
