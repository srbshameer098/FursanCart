class GetAllAddressModel {
  GetAllAddressModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.type, 
      this.address, 
      this.fullName, 
      this.phone, 
      this.state, 
      this.city, 
      this.pincode, 
      this.houseNoOrBuildingName, 
      this.landmark, 
      this.userId, 
      this.shopId,});

  GetAllAddressModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    type = json['type'];
    address = json['address'];
    fullName = json['fullName'];
    phone = json['phone'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    houseNoOrBuildingName = json['houseNoOrBuildingName'];
    landmark = json['landmark'];
    userId = json['user_id'];
    shopId = json['shopId'];
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  dynamic type;
  String? address;
  String? fullName;
  String? phone;
  String? state;
  String? city;
  int? pincode;
  String? houseNoOrBuildingName;
  String? landmark;
  String? userId;
  dynamic shopId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['type'] = type;
    map['address'] = address;
    map['fullName'] = fullName;
    map['phone'] = phone;
    map['state'] = state;
    map['city'] = city;
    map['pincode'] = pincode;
    map['houseNoOrBuildingName'] = houseNoOrBuildingName;
    map['landmark'] = landmark;
    map['user_id'] = userId;
    map['shopId'] = shopId;
    return map;
  }
  static List<GetAllAddressModel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => GetAllAddressModel.fromJson(value)).toList();
  }}
