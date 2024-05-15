class GetFavouratesModel {
  GetFavouratesModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.userId, 
      this.items,});

  GetFavouratesModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? userId;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['userId'] = userId;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Items {
  Items({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.wishListId, 
      this.variantId, 
      this.variant,});

  Items.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    wishListId = json['wishListId'];
    variantId = json['variantId'];
    variant = json['Variant'] != null ? Variant.fromJson(json['Variant']) : null;
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? wishListId;
  String? variantId;
  Variant? variant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['wishListId'] = wishListId;
    map['variantId'] = variantId;
    if (variant != null) {
      map['Variant'] = variant?.toJson();
    }
    return map;
  }

}

class Variant {
  Variant({
      this.id, 
      this.name, 
      this.value, 
      this.sku, 
      this.productId, 
      this.product,});

  Variant.fromJson(dynamic json) {
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
  dynamic referalBonus;
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
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Images {
  Images({
      this.id, 
      this.url,});

  Images.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
  }
  String? id;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    return map;
  }

}