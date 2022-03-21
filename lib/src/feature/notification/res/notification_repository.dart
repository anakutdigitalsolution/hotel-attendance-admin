import 'package:dio/dio.dart';

import 'package:hotle_attendnce_admin/src/feature/notification/model/notification_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class NotificationRepository {
  String mainUrl = "http://my-attendance-test-demo.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<NotificationModel>> getNotification() async {
    try {
      String url = mainUrl + "notification";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<NotificationModel> anounce = [];
        response.data["data"].forEach((data) {
          anounce.add(NotificationModel.fromJson(data));
        });
        return anounce;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
