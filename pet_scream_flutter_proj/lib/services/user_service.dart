
import 'package:pet_scream_flutter_proj/models/jwt-model.dart';
import 'package:pet_scream_flutter_proj/models/login-model.dart';
import 'package:pet_scream_flutter_proj/models/register-model.dart';

import 'http_service.dart';
import 'dart:convert';
import 'dart:async';

class UserService extends HttpService{

  Future<JWTToken> loginUser( UserLogin _user ) async {
    var response = await post('/api/Account/Login', jsonEncode( _user.toJson() ) );
    if( response.statusCode == 200 ){
      return  JWTToken.fromJson( jsonDecode( response.body ) );
    }else{
      if( response.statusCode ==  404){
        var aux = jsonDecode( response.body );

        return JWTToken.forJson(aux["Error"], DateTime.now());
      }
      throw Exception(response.body);
    }
  }

  Future<JWTToken> registerUser( UserRegister _user ) async {
    var response = await post('/api/Account/Register', jsonEncode( _user.toJson() ) );
    if( response.statusCode == 200 ){
      return  JWTToken.fromJson( jsonDecode( response.body ) );
    }else{
      if( response.statusCode ==  404){
        var aux = jsonDecode( response.body );

        return JWTToken.forJson(aux["Error"], DateTime.now());
      }
      throw Exception(response.body);
    }
  }

}