class DecreaseCartQuantityModel {
  DecreaseCartQuantityModel({
    this.msg,
    this.updated,
  });

  String? msg;
  Updated? updated;

  factory DecreaseCartQuantityModel.fromJson(Map<String, dynamic> json) {
    return DecreaseCartQuantityModel(
      msg: json['msg'],
      updated: json['updated'] != null ? Updated.fromJson(json['updated']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (updated != null) {
      data['updated'] = updated!.toJson();
    }
    return data;
  }
}

class Updated {
  Updated({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.productsId,
    this.cartId,
    this.price,
    this.quantity,
  });

  String? id;
  String? createdAt;
  String? updatedAt;
  String? productsId;
  String? cartId;
  dynamic price; // change the type to num
  int? quantity;

  factory Updated.fromJson(Map<String, dynamic> json) {
    return Updated(
      id: json['id']  as String,
      createdAt: json['createdAt']as String,
      updatedAt: json['updatedAt']as String,
      productsId: json['productsId']as String,
      cartId: json['cartId']as String,
      price: json['price'] as String,
      quantity: json['quantity']as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['productsId'] = productsId;
    data['cartId'] = cartId;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}
