import 'package:book_nook_user/data/models/Book.dart';

class LibraryProfile {
  Library? libraryInfo;
  LibraryAddress? libraryAddress;
  String? email;

  LibraryProfile({this.libraryInfo, this.libraryAddress, this.email});

  LibraryProfile.fromJson(Map<String, dynamic> json) {
    libraryInfo = json['Library_info'] != null
        ? new Library().fromJson1(json['Library_info'])
        : null;
    libraryAddress = json['library_address'] != null
        ? new LibraryAddress.fromJson(json['library_address'])
        : null;
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.libraryInfo != null) {
      data['Library_info'] = this.libraryInfo!.toJson();
    }
    if (this.libraryAddress != null) {
      data['library_address'] = this.libraryAddress!.toJson();
    }
    return data;
  }
}

class LibraryInfo {
  int? id;
  int? userId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? libraryName;
  int? phone;
  String? openTime;
  String? closeTime;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  LibraryInfo(
      {this.id,
      this.userId,
      this.firstName,
      this.middleName,
      this.lastName,
      this.libraryName,
      this.phone,
      this.openTime,
      this.closeTime,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  LibraryInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    libraryName = json['library_name'];
    phone = json['phone'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['library_name'] = this.libraryName;
    data['phone'] = this.phone;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class LibraryAddress {
  int? id;
  int? userId;
  String? title;
  String? area;
  String? street;
  int? floor;
  String? near;
  String? details;
  String? createdAt;
  String? updatedAt;

  LibraryAddress(
      {this.id,
      this.userId,
      this.title,
      this.area,
      this.street,
      this.floor,
      this.near,
      this.details,
      this.createdAt,
      this.updatedAt});

  LibraryAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    area = json['area'];
    street = json['street'];
    floor = json['floor'];
    near = json['near'];
    details = json['details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['area'] = this.area;
    data['street'] = this.street;
    data['floor'] = this.floor;
    data['near'] = this.near;
    data['details'] = this.details;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
