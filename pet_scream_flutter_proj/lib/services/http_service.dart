
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:pet_scream_flutter_proj/environment/development.dart';

class HttpService{
  static bool _certificateCheck(X509Certificate cert, String host, int port) => true;
  static http.Client client() {
    var ioClient = new HttpClient()..badCertificateCallback = _certificateCheck;

    return new IOClient(ioClient);
  }

  Map<String, String> requestHeaders = {
    'content-type': 'application/json'
  };


  Future<Response> getMyVersion(String path) async{
    return await http.get(Uri.parse(DevelopmentEnvironment.apiUrl+path));
  }

  Future<Response> get(String path) async{
    //return await client().get(DevelopmentEnvironment.apiUrl + path, headers: requestHeaders).timeout(Duration(seconds:5));
    return await http.get(Uri.parse(DevelopmentEnvironment.apiUrl + path));
  }
  Future<Response> getWithAuthorization(String path, String token) async{
    //return await client().get(DevelopmentEnvironment.apiUrl + path, headers: requestHeaders).timeout(Duration(seconds:5));
    return await http.get(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers: {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer $token'});
  }
  Future<Response> post(String path, var jsonBody) async{
    //return await client().get(DevelopmentEnvironment.apiUrl + path, headers: requestHeaders).timeout(Duration(seconds:5));
    return await client().post(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers: requestHeaders, body: jsonBody);
  }
  Future<Response> postWithAuthorization(String path, String token, var jsonBody) async{
    //return await client().get(DevelopmentEnvironment.apiUrl + path, headers: requestHeaders).timeout(Duration(seconds:5));
    return await http.post(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers: {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer $token'}, body: jsonBody);
  }
  Future<Response> postWithAuthorizationNoBody(String path, String token) async{
    //return await client().get(DevelopmentEnvironment.apiUrl + path, headers: requestHeaders).timeout(Duration(seconds:5));
    return await http.post(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers: {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer $token'} );
  }
  Future<Response> putWithAuthorization( String path, String token, var jsonBody ) async{
    return await http.put(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers: {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer $token'}, body: jsonBody );
  }
}
