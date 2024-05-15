class GetAllOrders {
  GetAllOrders({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.totalAmount, 
      this.custId, 
      this.customer, 
      this.products,});

  GetAllOrders.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    totalAmount = json['totalAmount'];
    custId = json['custId'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
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
  Customer? customer;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['totalAmount'] = totalAmount;
    map['custId'] = custId;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
  static List<GetAllOrders> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => GetAllOrders.fromJson(value)).toList();
  }}


class Products {
  Products({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.productName, 
      this.quantity, 
      this.unit, 
      this.totPrice, 
      this.prodId, 
      this.orderId, 
      this.dlvryId, 
      this.orderStatuss, 
      this.paymentDetails, 
      this.product,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productName = json['productName'];
    quantity = json['quantity'];
    unit = json['unit'];
    totPrice = json['totPrice'];
    prodId = json['prodId'];
    orderId = json['orderId'];
    dlvryId = json['dlvryId'];
    if (json['orderStatuss'] != null) {
      orderStatuss = [];
      json['orderStatuss'].forEach((v) {
        orderStatuss?.add(OrderStatuss.fromJson(v));
      });
    }
    if (json['payment_details'] != null) {
      paymentDetails = [];
      json['payment_details'].forEach((v) {
        paymentDetails?.add(PaymentDetails.fromJson(v));
      });
    }
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? productName;
  int? quantity;
  String? unit;
  String? totPrice;
  String? prodId;
  String? orderId;
  String? dlvryId;
  List<OrderStatuss>? orderStatuss;
  List<PaymentDetails>? paymentDetails;
  Product? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['productName'] = productName;
    map['quantity'] = quantity;
    map['unit'] = unit;
    map['totPrice'] = totPrice;
    map['prodId'] = prodId;
    map['orderId'] = orderId;
    map['dlvryId'] = dlvryId;
    if (orderStatuss != null) {
      map['orderStatuss'] = orderStatuss?.map((v) => v.toJson()).toList();
    }
    if (paymentDetails != null) {
      map['payment_details'] = paymentDetails?.map((v) => v.toJson()).toList();
    }
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

class PaymentDetails {
  PaymentDetails({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.amount, 
      this.provider, 
      this.type, 
      this.orderedProductsId,});

  PaymentDetails.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    amount = json['amount'];
    provider = json['provider'];
    type = json['type'];
    orderedProductsId = json['orderedProductsId'];
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? amount;
  String? provider;
  String? type;
  String? orderedProductsId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['amount'] = amount;
    map['provider'] = provider;
    map['type'] = type;
    map['orderedProductsId'] = orderedProductsId;
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

class Customer {
  Customer({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.name, 
      this.phone, 
      this.email, 
      this.authId, 
      this.referralCode, 
      this.walletBalance, 
      this.addresses,});

  Customer.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    authId = json['authId'];
    referralCode = json['referralCode'];
    walletBalance = json['walletBalance'];
    if (json['addresses'] != null) {
      addresses = [];
      json['addresses'].forEach((v) {
        addresses?.add(Addresses.fromJson(v));
      });
    }
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  dynamic phone;
  String? email;
  String? authId;
  String? referralCode;
  dynamic walletBalance;
  List<Addresses>? addresses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['authId'] = authId;
    map['referralCode'] = referralCode;
    map['walletBalance'] = walletBalance;
    if (addresses != null) {
      map['addresses'] = addresses?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Addresses {
  Addresses({
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

  Addresses.fromJson(dynamic json) {
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