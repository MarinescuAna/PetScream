import 'dart:convert';

import 'package:petscream_flutter_app/models/post_sender_model.dart';
import 'package:petscream_flutter_app/services/http_service.dart';
import 'package:petscream_flutter_app/singleton/singleton_keeper.dart';

class AdService extends HttpService {
  Future<bool> insertAd(PostSender _post) async {
    var response = await postWithAuthorization('/api/Ad/InsertAd',SingletonKeeper.GetToken(), jsonEncode(_post.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      if (response.statusCode == 404) {
        throw Exception(jsonDecode(response.body));
      }
      throw Exception(response.body);
    }
  }
}
