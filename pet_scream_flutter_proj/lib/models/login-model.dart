
class UserLogin{
  String email;
  String password;

  UserLogin({this.email,this.password});

  Map<String, dynamic> toJson(){
    return {
      "email": email,
      "password": password,
    };
  }
}