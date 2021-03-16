
class StatusCode{
  final int status;
  StatusCode({this.status});

  factory StatusCode.fromJson( Map<String, dynamic> json ){
    return StatusCode(
      status: json["statusType"],
    );
  }

}