
import 'package:flutter/foundation.dart';

class JWTToken {
  String _token;
  String _tokenExpirationDate;
  String _errorMessage=null;

  JWTToken.forJson( this._token, this._tokenExpirationDate);
  JWTToken.forJsonError( this._errorMessage);

  factory JWTToken.fromJson( Map<String, dynamic> json ){
    return JWTToken.forJson( json["accessToken"].toString(), json["accessTokenExpiration"] );
  }

  factory JWTToken.setError(String message){
    return JWTToken.forJsonError(message);
  }

  String get token => _token;
  String get tokenExpirationDate => _tokenExpirationDate;
  String get error => _errorMessage;
}