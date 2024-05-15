class GetCartModel {
  GetCartModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.totalPrice, 
      this.userId, 
      this.cartProducts,});

  GetCartModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    totalPrice = json['totalPrice'];
    userId = json['userId'];
    if (json['CartProducts'] != null) {
      cartProducts = [];
      json['CartProducts'].forEach((v) {
        cartProducts?.add(CartProducts.fromJson(v));
      });
    }
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? totalPrice;
  String? userId;
  List<CartProducts>? cartProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['totalPrice'] = totalPrice;
    map['userId'] = userId;
    if (cartProducts != null) {
      map['CartProducts'] = cartProducts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CartProducts {
  CartProducts({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.productVarientId, 
      this.cartId, 
      this.price, 
      this.quantity, 
      this.productVarient,});

  CartProducts.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productVarientId = json['productVarientId'];
    cartId = json['cartId'];
    price = json['price'];
    quantity = json['quantity'];
    productVarient = json['productVarient'] != null ? ProductVarient.fromJson(json['productVarient']) : null;
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? productVarientId;
  String? cartId;
  String? price;
  int? quantity;
  ProductVarient? productVarient;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['productVarientId'] = productVarientId;
    map['cartId'] = cartId;
    map['price'] = price;
    map['quantity'] = quantity;
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
      this.product,});

  ProductVarient.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    sku = json['sku'];
    productId = json['productId'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  String? id;
  String? name;
  String? value;
  String? sku;
  String? productId;
  Product? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['value'] = value;
    map['sku'] = sku;
    map['productId'] = productId;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    return map;
  }

}

class Product {
  Product({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.name, 
      this.description, 
      this.price, 
      this.discountedAmount, 
      this.stockQuantity, 
      this.sku, 
      this.slug, 
      this.rating, 
      this.weight, 
      this.discountPercent, 
      this.specifications, 
      this.highlights, 
      this.tags, 
      this.returnDays, 
      this.refund, 
      this.replace, 
      this.unit, 
      this.brandsId, 
      this.categoryId, 
      this.subCategoryId, 
      this.status, 
      this.creatorId, 
      this.madeBy, 
      this.deleted, 
      this.deletedBy, 
      this.referalBonus, 
      this.discPerQtt, 
      this.images,});

  Product.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    discountedAmount = json['discountedAmount'];
    stockQuantity = json['stockQuantity'];
    sku = json['sku'];
    slug = json['slug'];
    rating = json['rating'];
    weight = json['weight'];
    discountPercent = json['discount_percent'];
    specifications = json['specifications'];
    highlights = json['highlights'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    returnDays = json['returnDays'];
    refund = json['refund'];
    replace = json['replace'];
    unit = json['unit'];
    brandsId = json['brandsId'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    status = json['status'];
    creatorId = json['creatorId'];
    madeBy = json['madeBy'];
    deleted = json['deleted'];
    deletedBy = json['deletedBy'];
    referalBonus = json['referalBonus'];
    if (json['discPerQtt'] != null) {
      discPerQtt = [];
      json['discPerQtt'].forEach((v) {
        discPerQtt?.add(DiscPerQtt.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? description;
  String? price;
  String? discountedAmount;
  int? stockQuantity;
  String? sku;
  String? slug;
  int? rating;
  String? weight;
  String? discountPercent;
  String? specifications;
  String? highlights;
  List<String>? tags;
  int? returnDays;
  bool? refund;
  bool? replace;
  String? unit;
  String? brandsId;
  String? categoryId;
  dynamic subCategoryId;
  String? status;
  String? creatorId;
  String? madeBy;
  bool? deleted;
  dynamic deletedBy;
  String? referalBonus;
  List<DiscPerQtt>? discPerQtt;
  List<Images>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['discountedAmount'] = discountedAmount;
    map['stockQuantity'] = stockQuantity;
    map['sku'] = sku;
    map['slug'] = slug;
    map['rating'] = rating;
    map['weight'] = weight;
    map['discount_percent'] = discountPercent;
    map['specifications'] = specifications;
    map['highlights'] = highlights;
    map['tags'] = tags;
    map['returnDays'] = returnDays;
    map['refund'] = refund;
    map['replace'] = replace;
    map['unit'] = unit;
    map['brandsId'] = brandsId;
    map['categoryId'] = categoryId;
    map['subCategoryId'] = subCategoryId;
    map['status'] = status;
    map['creatorId'] = creatorId;
    map['madeBy'] = madeBy;
    map['deleted'] = deleted;
    map['deletedBy'] = deletedBy;
    map['referalBonus'] = referalBonus;
    if (discPerQtt != null) {
      map['discPerQtt'] = discPerQtt?.map((v) => v.toJson()).toList();
    }
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

class DiscPerQtt {
  DiscPerQtt({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.qttFrom, 
      this.qttTo, 
      this.discPercent, 
      this.discFlatAmnt, 
      this.productsId,});

  DiscPerQtt.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    qttFrom = json['qttFrom'];
    qttTo = json['qttTo'];
    discPercent = json['discPercent'];
    discFlatAmnt = json['discFlatAmnt'];
    productsId = json['productsId'];
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  int? qttFrom;
  int? qttTo;
  String? discPercent;
  String? discFlatAmnt;
  String? productsId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['qttFrom'] = qttFrom;
    map['qttTo'] = qttTo;
    map['discPercent'] = discPercent;
    map['discFlatAmnt'] = discFlatAmnt;
    map['productsId'] = productsId;
    return map;
  }

}