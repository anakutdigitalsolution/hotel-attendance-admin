import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class EmployeeRepository {
  String mainUrl = "http://my-attendance-test-demo.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<EmployeeModel>> getEmployee(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "employees?page_size=$rowPerpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<EmployeeModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(EmployeeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<EmployeeModel>> getAllEmployee() async {
    try {
      String url = mainUrl + "employees";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<EmployeeModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(EmployeeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addEmployee({
    required String name,
    required String gender,
    required String img,
    required String email,
    required String dob,
    required String officeTel,
    required String username,
    required String password,
    required String positionId,
    required String departmentId,
    required String storeId,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      String url = mainUrl + "employees/add";
      Map body = {
        "name": name,
        "gender": gender,
        "username": username,
        "email": email,
        "dob": dob,
        "office_tel": officeTel,
        "password": password,
        "profile_url": img,
        "position_id": positionId,
        "department_id": departmentId,
        "store_id": storeId,
        "employee_phone": phoneNumber,
        "address": address,
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

  Future<void> editEmployee({
    required String id,
    required String name,
    required String gender,
    required String email,
    required String dob,
    required String officeTel,
    required String img,
    // required String username,
    // required String password,
    required String positionId,
    required String departmentId,
    required String storeId,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      String url = mainUrl + "employees/edit/$id";
      Map body = {
        "name": name,
        "gender": gender,
        "email": email,
        "dob": dob,
        "office_tel": officeTel,
        "profile_url": img,
        "position_id": positionId,
        "department_id": departmentId,
        "store_id": storeId,
        "employee_phone": phoneNumber,
        "address": address,
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

  Future<void> deleteEmployee({
    required String id,
  }) async {
    try {
      String url = mainUrl + "employee/delete/$id";

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
