
class JWTToken {
  String _token;
  DateTime _tokenExpirationDate;

  JWTToken.forJson( this._token, this._tokenExpirationDate);

  factory JWTToken.fromJson( Map<String, dynamic> json ){
    return JWTToken.forJson( json["accessToken"].toString(), DateTime.parse(json["accessTokenExpiration"]) );
  }

  String get token => _token;
  DateTime get tokenExpirationDate => _tokenExpirationDate;

}