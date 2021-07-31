class ProfileInfo {
  String firstName;
  String lastName;
  String mobileNumber;
  String mailID;
  String id;
  String imageUrl;
  String storeId;
  String websSiteid;

  ProfileInfo({this.firstName, this.lastName, this.mobileNumber,this.mailID,this.id,this.storeId,this.websSiteid,this.imageUrl});

  @override
  String toString() {
    return 'ProfileInfo{firstName: $firstName, lastName: $lastName, mobileNumber: $mobileNumber, mailID:$mailID, id:$id, storeId:$storeId,webSiteId:$websSiteid,imageUrl:$imageUrl}';
  }
}