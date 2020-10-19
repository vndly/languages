import 'dart:convert';
import 'package:Languages/api/end_points/open_endpoint.dart';
import 'package:Languages/json/json_category.dart';
import 'package:dahttp/dahttp.dart';
import 'package:http/http.dart';

class GetCategories extends OpenEndPoint<List<JsonCategory>> {
  GetCategories() : super();

  Future<HttpResult<List<JsonCategory>>> call() => super.get(
      '/macros/s/AKfycbxHDjaT3RIMQSMeQcL0NqGXiaVxDV-LKYGEda3djWnSFQ1lXwni/exec');

  @override
  List<JsonCategory> convert(Response response) {
    final json = jsonDecode(response.body);

    return JsonCategory.fromJsonList(json);
  }
}
