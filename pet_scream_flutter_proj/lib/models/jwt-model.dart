import 'package:pet_scream_flutter_proj/services/user_service.dart';

import '../locator.dart';

class JWTToken {
  String _token;
  DateTime _tokenExpirationDate;
  final UserService _userService = locator<UserService>();

  JWTToken.forJson( this._token, this._tokenExpirationDate);

  factory JWTToken.fromJson( Map<String, dynamic> json ){
    return JWTToken.forJson( json["accessToken"].toString(), DateTime.parse(json["accessTokenExpiration"]) );
  }

  String get token => _token;
  DateTime get tokenExpirationDate => _tokenExpirationDate;
}

