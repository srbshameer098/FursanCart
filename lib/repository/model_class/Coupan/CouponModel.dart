class CouponModel {
  CouponModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.couponCode, 
      this.discountAmount, 
      this.status, 
      this.expirationDate, 
      this.usageLimit, 
      this.usageCount, 
      this.minimumPurchaseAmount, 
      this.description, 
      this.isActive, 
      this.stock, 
      this.adminId, 
      this.shopId, 
      this.couponPerProdsOrCates,});

  CouponModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    couponCode = json['coupon_code'];
    discountAmount = json['discountAmount'];
    status = json['status'];
    expirationDate = json['expirationDate'];
    usageLimit = json['usageLimit'];
    usageCount = json['usageCount'];
    minimumPurchaseAmount = json['minimumPurchaseAmount'];
    description = json['description'];
    isActive = json['isActive'];
    stock = json['stock'];
    adminId = json['adminId'];
    shopId = json['shopId'];
    if (json['couponPerProdsOrCates'] != null) {
      couponPerProdsOrCates = [];
      json['couponPerProdsOrCates'].forEach((v) {
        couponPerProdsOrCates?.add(v);
      });
    }
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? couponCode;
  String? discountAmount;
  String? status;
  String? expirationDate;
  int? usageLimit;
  int? usageCount;
  String? minimumPurchaseAmount;
  String? description;
  bool? isActive;
  int? stock;
  String? adminId;
  dynamic shopId;
  List<dynamic>? couponPerProdsOrCates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['coupon_code'] = couponCode;
    map['discountAmount'] = discountAmount;
    map['status'] = status;
    map['expirationDate'] = expirationDate;
    map['usageLimit'] = usageLimit;
    map['usageCount'] = usageCount;
    map['minimumPurchaseAmount'] = minimumPurchaseAmount;
    map['description'] = description;
    map['isActive'] = isActive;
    map['stock'] = stock;
    map['adminId'] = adminId;
    map['shopId'] = shopId;
    if (couponPerProdsOrCates != null) {
      map['couponPerProdsOrCates'] = couponPerProdsOrCates?.map((v) => v.toJson()).toList();
    }
    return map;
  }
  static List<CouponModel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => CouponModel.fromJson(value)).toList();
  }}
