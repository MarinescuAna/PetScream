
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:petscream_flutter_app/environment/development.dart';
import 'package:petscream_flutter_app/singleton/singleton_keeper.dart';

class HttpService{
  static bool _certificateCheck(X509Certificate cert, String host, int port) => true;
  static http.Client client() {
    var ioClient = new HttpClient()..badCertificateCallback = _certificateCheck;

    return new IOClient(ioClient);
  }

  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Response> get(String path) async{
    //return await client().get(DevelopmentEnvironment.apiUrl + path, headers: requestHeaders).timeout(Duration(seconds:5));
    return await client().get(Uri.parse(DevelopmentEnvironment.apiUrl + path));
  }
  Future<Response> getWithAuthorization(String path) async{
    var token = SingletonKeeper.GetToken();
    //return await client().get(DevelopmentEnvironment.apiUrl + path, headers: requestHeaders).timeout(Duration(seconds:5));
    return await client().get(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers:  {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer  " + token  ,
    });
  }

  Future<Response> post(String path, var jsonBody) async{
    //return await client().get(DevelopmentEnvironment.apiUrl + path, headers: requestHeaders).timeout(Duration(seconds:5));
    return await client().post(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers: requestHeaders, body: jsonBody);
  }

  Future<Response> postWithAuthorization(String path, var jsonBody) async{
    var token = SingletonKeeper.GetToken();
    //return await client().get(DevelopmentEnvironment.apiUrl + path, headers: requestHeaders).timeout(Duration(seconds:5));
    return await client().post(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers:  {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer  " + token  ,
    }, body: jsonBody);
  }

  Future<Response> postWithAuthorizationNoBody(String path) async{
    var token = SingletonKeeper.GetToken();
    //return await client().get(DevelopmentEnvironment.apiUrl + path, headers: requestHeaders).timeout(Duration(seconds:5));
    return await client().post(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers:  {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer  " + token  ,
    } );
  }

  Future<Response> putWithAuthorization( String path,  var jsonBody ) async{
    var token = SingletonKeeper.GetToken();
    return await client().put(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers:  {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer  " + token  ,
    }, body: jsonBody );
  }

  Future<Response> put( String path,  var jsonBody ) async{
    return await client().put(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers: requestHeaders, body: jsonBody );
  }

  Future<Response> delete( String path) async{
    return await client().delete(Uri.parse(DevelopmentEnvironment.apiUrl + path), headers: requestHeaders);
  }
}
