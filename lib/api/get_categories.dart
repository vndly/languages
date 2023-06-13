import 'dart:convert';
import 'package:dahttp/dahttp.dart';
import 'package:http/http.dart';
import 'package:languages/json/json_category.dart';
import 'package:languages/json/json_profile.dart';
import 'package:languages/storage/profile_storage.dart';

class GetCategories extends ValuedHttpClient<List<JsonCategory>> {
  GetCategories() : super(logger: DefaultHttpLogger(headers: true, body: true));

  Future<HttpResult<List<JsonCategory>>> call() async {
    final JsonProfile profile = await ProfileStorage.load();

    return super.get(profile.url);
  }

  @override
  List<JsonCategory> convert(Response response) {
    final json = jsonDecode(response.body);

    return JsonCategory.fromJsonList(json);
  }
}
