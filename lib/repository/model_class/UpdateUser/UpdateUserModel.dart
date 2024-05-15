class UpdateUserModel {
  UpdateUserModel({
      this.msg, 
      this.res,});

  UpdateUserModel.fromJson(dynamic json) {
    msg = json['msg'];
    res = json['res'] != null ? Res.fromJson(json['res']) : null;
  }
  String? msg;
  Res? res;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    if (res != null) {
      map['res'] = res?.toJson();
    }
    return map;
  }

}

class Res {
  Res({
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
      this.walletBalance,});

  Res.fromJson(dynamic json) {
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
    return map;
  }

}