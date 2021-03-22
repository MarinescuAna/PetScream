
class JWTToken {
  String _token;
  String _tokenExpirationDate;

  JWTToken.forJson( this._token, this._tokenExpirationDate);

  factory JWTToken.fromJson( Map<String, dynamic> json ){
    return JWTToken.forJson( json["accessToken"].toString(), json["accessTokenExpiration"] );
  }

  String get token => _token;
  String get tokenExpirationDate => _tokenExpirationDate;

}