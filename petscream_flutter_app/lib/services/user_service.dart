import 'package:petscream_flutter_app/models/jwt_model.dart';
import 'package:petscream_flutter_app/models/login_model.dart';
import 'package:petscream_flutter_app/models/register_model.dart';
import 'package:petscream_flutter_app/singleton/singleton_keeper.dart';

import 'http_service.dart';
import 'dart:convert';
import 'dart:async';

class UserService extends HttpService {
  Future<JWTToken> loginUser(UserLogin _user) async {
    var response = await post('/api/Account/Login', jsonEncode(_user.toJson()));
    if (response.statusCode == 201) {
      return JWTToken.fromJson(jsonDecode(response.body));
    }
    return JWTToken.forJsonError(response.body);
  }

  Future<JWTToken> registerUser(UserRegister _user) async {
    var response =
        await post('/api/Account/Register', jsonEncode(_user.toJson()));
    if (response.statusCode == 201) {
      return JWTToken.fromJson(jsonDecode(response.body));
    } else {
      if (response.statusCode == 201) {
        return JWTToken.fromJson(jsonDecode(response.body));
      }
      return JWTToken.forJsonError(response.body);
    }
  }
}
