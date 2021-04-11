import 'dart:convert';

import 'package:petscream_flutter_app/models/ad_rec_model.dart';
import 'package:petscream_flutter_app/models/post_sender_model.dart';
import 'package:petscream_flutter_app/services/http_service.dart';
import 'package:petscream_flutter_app/singleton/singleton_keeper.dart';

class AdService extends HttpService {
  Future<String> insertAd(PostSender _post) async {
    var response = await postWithAuthorization('/api/Ad/InsertAd',SingletonKeeper.GetToken(), jsonEncode(_post.toJson()));
    if (response.statusCode == 200) {
      return "Success";
    } else {
     return response.statusCode.toString();
    }
  }

  Future<List<AdRecModel>> getAds() async {
    var response = await get('/api/Ad/GetAds');
    if( response.statusCode == 200 ){
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<AdRecModel>( (json) => AdRecModel.fromJson(json) ).toList();
    }else{
      throw Exception('Failed to load events');
    }
  }
}
