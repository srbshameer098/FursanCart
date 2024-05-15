class GetUserDetailsModel {
  GetUserDetailsModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.username, 
      this.email, 
      this.phone,
      this.role, 
      this.blocked, 
      this.verified, 
      this.refreshToken, 
      this.referralCode, 
      this.walletBalance, 
      this.shippingAddress, 
      this.cart, 
      this.orders, 
      this.image, 
      this.referals, 
      this.referredBy,});

  GetUserDetailsModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    blocked = json['blocked'];
    verified = json['verified'];
    refreshToken = json['refreshToken'];
    referralCode = json['referralCode'];
    walletBalance = json['walletBalance'];
    if (json['ShippingAddress'] != null) {
      shippingAddress = [];
      json['ShippingAddress'].forEach((v) {
        shippingAddress?.add(ShippingAddress.fromJson(v));
      });
    }
    cart = json['Cart'] != null ? Cart.fromJson(json['Cart']) : null;
    if (json['Orders'] != null) {
      orders = [];
      json['Orders'].forEach((v) {
        orders?.add(v);
      });
    }
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(v);
      });
    }
    if (json['Referals'] != null) {
      referals = [];
      json['Referals'].forEach((v) {
        referals?.add(v);
      });
    }
    referredBy = json['ReferredBy'];
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? username;
  String? email;
  dynamic phone;
  String? role;
  bool? blocked;
  bool? verified;
  dynamic refreshToken;
  String? referralCode;
  dynamic walletBalance;
  List<ShippingAddress>? shippingAddress;
  Cart? cart;
  List<dynamic>? orders;
  List<dynamic>? image;
  List<dynamic>? referals;
  dynamic referredBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['username'] = username;
    map['email'] = email;
    map['phone'] = phone;
    map['role'] = role;
    map['blocked'] = blocked;
    map['verified'] = verified;
    map['refreshToken'] = refreshToken;
    map['referralCode'] = referralCode;
    map['walletBalance'] = walletBalance;
    if (shippingAddress != null) {
      map['ShippingAddress'] = shippingAddress?.map((v) => v.toJson()).toList();
    }
    if (cart != null) {
      map['Cart'] = cart?.toJson();
    }
    if (orders != null) {
      map['Orders'] = orders?.map((v) => v.toJson()).toList();
    }
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    if (referals != null) {
      map['Referals'] = referals?.map((v) => v.toJson()).toList();
    }
    map['ReferredBy'] = referredBy;
    return map;
  }

}

class Cart {
  Cart({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.totalPrice, 
      this.userId,});

  Cart.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    totalPrice = json['totalPrice'];
    userId = json['userId'];
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? totalPrice;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['totalPrice'] = totalPrice;
    map['userId'] = userId;
    return map;
  }

}

class ShippingAddress {
  ShippingAddress({
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

  ShippingAddress.fromJson(dynamic json) {
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
  String? type;
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

}