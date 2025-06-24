import 'package:get/get.dart';

class BaseApi extends GetConnect {
  // late SharedPreferences prefs;
  @override
  void onInit() {
    super.onInit();
    httpClient.timeout = const Duration(seconds: 60);
  }


  Future<Response?> sendPost(String? url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query}) async {
    // if (!await isInternetConnected()) {
    //   utils.showToast("Error", "Failed to reach network");
    //   return null;
    // }
    var response = await post(url, FormData(body),
        contentType: contentType, headers: headers, query: query);
    if (response.statusCode != 200) {
      Get.snackbar("Error", "Internal server error.",
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }

    return response;
  }

  Future<Response?> sendGet(String url,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query}) async {
    // if (!await isInternetConnected()) {
    //   utils.showToast("Error", "Failed to reach network");
    //   return null;
    // }
    var response = await get(url,
        contentType: contentType, headers: headers, query: query);
    if (response.statusCode != 200) {
      Get.snackbar("Error", "Internal server error.",
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }

    return response;
  }

  BaseApi() : super(timeout: const Duration(seconds: 2));
}
