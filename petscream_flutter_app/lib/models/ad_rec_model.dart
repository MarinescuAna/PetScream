

class AdRecModel{
  String postID;
  String title;
  String petDescription;
  String ownerAddress;
  String founderAddress;
  String lostPlaceAddress;
  String founderName;
  String founderPhone;
  String lostDatetime;
  String postDatetime;
  String foundDatetime;
  String status;
  String userEmail;
  String contentImage;
  String name;
  String phone;

  AdRecModel(
      {
        this.lostDatetime,
        this.title,
        this.foundDatetime,
        this.lostPlaceAddress,
        this.ownerAddress,
        this.petDescription,
        this.name,
        this.phone,
        this.contentImage,
        this.founderAddress,
        this.founderName,
        this.founderPhone,
        this.postDatetime,
        this.postID,
        this.status,
        this.userEmail
      }
      );

  factory AdRecModel.fromJson( Map<String, dynamic> json ){
    return AdRecModel(
        postID: json["postID"],
        title: json["title"],
        petDescription: json["petDescription"],
        ownerAddress: json["ownerAddress"],
        founderAddress: json["founderAddress"],
        lostPlaceAddress: json["lostPlaceAddress"],
        founderName: json["founderName"],
        founderPhone: json["founderPhone"],
        lostDatetime: json["lostDatetime"],
        postDatetime: json["postDatetime"],
        foundDatetime: json["foundDatetime"],
        status: json["status"],
        userEmail: json["userEmail"],
        contentImage: json["contentImage"],
        name :json["name"]
    );
  }
}