class PostSender{
  String title;
  String petDescription;
  String ownerAddress;
  String lostPlaceAddress;
  String binaryContentImage;
  String imageName;
  String extentionImage;
  String lostDatetime;

  PostSender({
    this.title,
    this.petDescription,
    this.ownerAddress,
    this.lostPlaceAddress,
    this.binaryContentImage,
    this.imageName,
    this.extentionImage,
    this.lostDatetime
  });

  Map<String, dynamic> toJson(){
    return {
      "title": title,
      "petDescription": petDescription,
      "ownerAddress": ownerAddress,
      "lostPlaceAddress": lostPlaceAddress,
      "binaryContentImage": binaryContentImage,
      "imageName": imageName,
      "extentionImage": extentionImage,
      "lostDatetime":lostDatetime
    };
  }
}