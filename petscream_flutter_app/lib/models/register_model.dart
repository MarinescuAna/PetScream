
class UserRegister{
  final String email;
  final String name;
  final String phone;
  final String password;

  UserRegister( {this.email, this.name, this.phone, this.password} );

  Map<String, dynamic> toJson(){
    return {
      "email": email,
      "name": name,
      "password": password,
      "phone": phone
    };
  }

  factory UserRegister.fromJson( Map<String, dynamic> json ){
    return UserRegister(
      email: json["email"],
      name: json["name"],
      password: json["password"],
      phone: json["phone"],
    );
  }

}