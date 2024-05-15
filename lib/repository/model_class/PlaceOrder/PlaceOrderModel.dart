class PlaceOrderModel {
  PlaceOrderModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.totalAmount, 
      this.custId, 
      this.deliveryTypesId, 
      this.deliveryType, 
      this.customer, 
      this.paymentDetails, 
      this.products,});

  PlaceOrderModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    totalAmount = json['totalAmount'];
    custId = json['custId'];
    deliveryTypesId = json['deliveryTypesId'];
    deliveryType = json['deliveryType'] != null ? DeliveryType.fromJson(json['deliveryType']) : null;
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    if (json['payment_details'] != null) {
      paymentDetails = [];
      json['payment_details'].forEach((v) {
        paymentDetails?.add(PaymentDetails.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? totalAmount;
  String? custId;
  String? deliveryTypesId;
  DeliveryType? deliveryType;
  Customer? customer;
  List<PaymentDetails>? paymentDetails;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['totalAmount'] = totalAmount;
    map['custId'] = custId;
    map['deliveryTypesId'] = deliveryTypesId;
    if (deliveryType != null) {
      map['deliveryType'] = deliveryType?.toJson();
    }
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    if (paymentDetails != null) {
      map['payment_details'] = paymentDetails?.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Products {
  Products({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.productName, 
      this.quantity, 
      this.unit, 
      this.totPrice, 
      this.varId, 
      this.orderId, 
      this.dlvryId, 
      this.orderStatuss, 
      this.productVarient,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productName = json['productName'];
    quantity = json['quantity'];
    unit = json['unit'];
    totPrice = json['totPrice'];
    varId = json['varId'];
    orderId = json['orderId'];
    dlvryId = json['dlvryId'];
    if (json['orderStatuss'] != null) {
      orderStatuss = [];
      json['orderStatuss'].forEach((v) {
        orderStatuss?.add(OrderStatuss.fromJson(v));
      });
    }
    productVarient = json['productVarient'] != null ? ProductVarient.fromJson(json['productVarient']) : null;
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? productName;
  int? quantity;
  String? unit;
  String? totPrice;
  String? varId;
  String? orderId;
  String? dlvryId;
  List<OrderStatuss>? orderStatuss;
  ProductVarient? productVarient;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['productName'] = productName;
    map['quantity'] = quantity;
    map['unit'] = unit;
    map['totPrice'] = totPrice;
    map['varId'] = varId;
    map['orderId'] = orderId;
    map['dlvryId'] = dlvryId;
    if (orderStatuss != null) {
      map['orderStatuss'] = orderStatuss?.map((v) => v.toJson()).toList();
    }
    if (productVarient != null) {
      map['productVarient'] = productVarient?.toJson();
    }
    return map;
  }

}

class ProductVarient {
  ProductVarient({
      this.id, 
      this.name, 
      this.value, 
      this.sku, 
      this.productId, 
      this.stockQuantity, 
      this.product,});

  ProductVarient.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    sku = json['sku'];
    productId = json['productId'];
    stockQuantity = json['stockQuantity'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  String? id;
  String? name;
  String? value;
  String? sku;
  String? productId;
  int? stockQuantity;
  Product? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['value'] = value;
    map['sku'] = sku;
    map['productId'] = productId;
    map['stockQuantity'] = stockQuantity;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    return map;
  }

}

class Product {
  Product({
      this.images,});

  Product.fromJson(dynamic json) {
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }
  List<Images>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Images {
  Images({
      this.url,});

  Images.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }

}

class OrderStatuss {
  OrderStatuss({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.status, 
      this.statusNote, 
      this.orderedProductsId,});

  OrderStatuss.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    statusNote = json['statusNote'];
    orderedProductsId = json['orderedProductsId'];
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? statusNote;
  String? orderedProductsId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['status'] = status;
    map['statusNote'] = statusNote;
    map['orderedProductsId'] = orderedProductsId;
    return map;
  }

}

class PaymentDetails {
  PaymentDetails({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.amount, 
      this.provider, 
      this.type, 
      this.orderedProductsId, 
      this.ordersId,});

  PaymentDetails.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    amount = json['amount'];
    provider = json['provider'];
    type = json['type'];
    orderedProductsId = json['orderedProductsId'];
    ordersId = json['ordersId'];
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? amount;
  String? provider;
  String? type;
  dynamic orderedProductsId;
  String? ordersId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['amount'] = amount;
    map['provider'] = provider;
    map['type'] = type;
    map['orderedProductsId'] = orderedProductsId;
    map['ordersId'] = ordersId;
    return map;
  }

}

class Customer {
  Customer({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.username, 
      this.email, 
      this.phone, 
      this.password, 
      this.role, 
      this.blocked, 
      this.verified, 
      this.refreshToken, 
      this.referralCode, 
      this.walletBalance, 
      this.shippingAddress,});

  Customer.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
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
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? username;
  String? email;
  dynamic phone;
  String? password;
  String? role;
  bool? blocked;
  bool? verified;
  dynamic refreshToken;
  String? referralCode;
  dynamic walletBalance;
  List<ShippingAddress>? shippingAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['username'] = username;
    map['email'] = email;
    map['phone'] = phone;
    map['password'] = password;
    map['role'] = role;
    map['blocked'] = blocked;
    map['verified'] = verified;
    map['refreshToken'] = refreshToken;
    map['referralCode'] = referralCode;
    map['walletBalance'] = walletBalance;
    if (shippingAddress != null) {
      map['ShippingAddress'] = shippingAddress?.map((v) => v.toJson()).toList();
    }
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

class DeliveryType {
  DeliveryType({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.name, 
      this.deliveryCharge, 
      this.amountSlab, 
      this.deliverIn,});

  DeliveryType.fromJson(dynamic json) {
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

}