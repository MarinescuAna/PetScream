import 'dart:convert';

import 'package:petscream_flutter_app/models/ad_rec_model.dart';
import 'package:petscream_flutter_app/models/founder_model.dart';
import 'package:petscream_flutter_app/models/post_sender_model.dart';
import 'package:petscream_flutter_app/services/http_service.dart';

class AdService extends HttpService {
  Future<String> insertAd(PostSender _post) async {
    var response = await postWithAuthorization('/api/Ad/InsertAd', jsonEncode(_post.toJson()));
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

  Future<String> DeletePost(String id) async{
    var response= await delete('/api/Ad/DeletePost?postId='+id);
    if (response.statusCode == 200) {
      return "Success";
    } else {
      return response.statusCode.toString();
    }
  }

  Future<String> Found(FounderModel model) async{
    var response = await put('/api/Ad/SentDataFounder',jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      return "Success";
    } else {
      return response.statusCode.toString();
    }
  }
  Future<String> MarkAsFound(String model) async{
    var response = await put('/api/Ad/MarkAsFound?postId='+model,"");
    if (response.statusCode == 200) {
      return "Success";
    } else {
      return response.statusCode.toString();
    }
  }

}
