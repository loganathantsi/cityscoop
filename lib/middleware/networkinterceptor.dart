import 'dart:async';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';
import 'package:http/http.dart' as http;

class NetworkInterceptor implements InterceptorContract {
  @override
  FutureOr<http.BaseRequest> interceptRequest({required http.BaseRequest request}) async {
    print("---> NetworkInterceptor Request : ${request.url} ${request.method} ${request.headers}");

    Utilities.getStringPreference(Strings.accessToken).then((accessTokenValue) {
      Utilities.getBoolPreference(Strings.loginSuccess).then((loginSuccessValue) async {
      if (loginSuccessValue && accessTokenValue != "") {
        request.headers['Authorization'] = 'Bearer $accessTokenValue';
      }});
    });
    return request;
  }

  @override
  FutureOr<http.BaseResponse> interceptResponse({required http.BaseResponse response}) {
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return false;
  }

}