class GetDeliveryTypeModel {
  GetDeliveryTypeModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.name, 
      this.deliveryCharge, 
      this.amountSlab, 
      this.deliverIn,});

  GetDeliveryTypeModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    deliveryCharge = json['deliveryCharge'];
    amountSlab = json['amountSlab'];
    deliverIn = json['deliverIn'];
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? deliveryCharge;
  String? amountSlab;
  String? deliverIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['name'] = name;
    map['deliveryCharge'] = deliveryCharge;
    map['amountSlab'] = amountSlab;
    map['deliverIn'] = deliverIn;
    return map;
  }
  static List<GetDeliveryTypeModel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => GetDeliveryTypeModel.fromJson(value)).toList();
  }}
