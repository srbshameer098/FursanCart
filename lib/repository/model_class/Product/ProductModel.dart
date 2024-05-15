class ProductModel {
  ProductModel({
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
      this.belongsTo, 
      this.brands, 
      this.category, 
      this.discPerQtt, 
      this.images, 
      this.review, 
      this.variants, 
      this.subCategory,});

  ProductModel.fromJson(dynamic json) {
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
    belongsTo = json['belongsTo'] != null ? BelongsTo.fromJson(json['belongsTo']) : null;
    brands = json['Brands'] != null ? Brands.fromJson(json['Brands']) : null;
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
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
    if (json['Review'] != null) {
      review = [];
      json['Review'].forEach((v) {
        review?.add(v);
      });
    }
    if (json['variants'] != null) {
      variants = [];
      json['variants'].forEach((v) {
        variants?.add(Variants.fromJson(v));
      });
    }
    subCategory = json['SubCategory'];
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
  BelongsTo? belongsTo;
  Brands? brands;
  Category? category;
  List<DiscPerQtt>? discPerQtt;
  List<Images>? images;
  List<dynamic>? review;
  List<Variants>? variants;
  dynamic subCategory;

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
    if (belongsTo != null) {
      map['belongsTo'] = belongsTo?.toJson();
    }
    if (brands != null) {
      map['Brands'] = brands?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (discPerQtt != null) {
      map['discPerQtt'] = discPerQtt?.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    if (review != null) {
      map['Review'] = review?.map((v) => v.toJson()).toList();
    }
    if (variants != null) {
      map['variants'] = variants?.map((v) => v.toJson()).toList();
    }
    map['SubCategory'] = subCategory;
    return map;
  }
  static List<ProductModel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => ProductModel.fromJson(value)).toList();
  }
}

class Variants {
  Variants({
      this.id, 
      this.name, 
      this.value, 
      this.sku, 
      this.productId, 
      this.stockQuantity, 
      this.wishListItem, 
      this.images, 
      this.wishlist,});

  Variants.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    sku = json['sku'];
    productId = json['productId'];
    stockQuantity = json['stockQuantity'];
    wishListItem = json['WishListItem'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    wishlist = json['Wishlist'];
  }
  String? id;
  String? name;
  String? value;
  String? sku;
  String? productId;
  dynamic stockQuantity;
  dynamic wishListItem;
  List<Images>? images;
  bool? wishlist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['value'] = value;
    map['sku'] = sku;
    map['productId'] = productId;
    map['stockQuantity'] = stockQuantity;
    map['WishListItem'] = wishListItem;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    map['Wishlist'] = wishlist;
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

// class Images {
//   Images({
//       this.id,
//       this.url,});
//
//   Images.fromJson(dynamic json) {
//     id = json['id'];
//     url = json['url'];
//   }
//   String? id;
//   String? url;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['url'] = url;
//     return map;
//   }
//
// }

class DiscPerQtt {
  DiscPerQtt({
      this.id, 
      this.discFlatAmnt, 
      this.discPercent, 
      this.qttFrom, 
      this.qttTo,});

  DiscPerQtt.fromJson(dynamic json) {
    id = json['id'];
    discFlatAmnt = json['discFlatAmnt'];
    discPercent = json['discPercent'];
    qttFrom = json['qttFrom'];
    qttTo = json['qttTo'];
  }
  String? id;
  String? discFlatAmnt;
  String? discPercent;
  int? qttFrom;
  int? qttTo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['discFlatAmnt'] = discFlatAmnt;
    map['discPercent'] = discPercent;
    map['qttFrom'] = qttFrom;
    map['qttTo'] = qttTo;
    return map;
  }

}

class Category {
  Category({
      this.id, 
      this.name, 
      this.image,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(Image1.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  List<Image1>? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Image1 {
  Image1({
      this.id, 
      this.url,});

  Image1.fromJson(dynamic json) {
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

class Brands {
  Brands({
      this.id, 
      this.name, 
      this.image,});

  Brands.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(Image1.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  List<Image1>? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

// class Image {
//   Image({
//       this.id,
//       this.url,});
//
//   Image.fromJson(dynamic json) {
//     id = json['id'];
//     url = json['url'];
//   }
//   String? id;
//   String? url;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['url'] = url;
//     return map;
//   }
//
// }

class BelongsTo {
  BelongsTo({
      this.id, 
      this.username, 
      this.role,});

  BelongsTo.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    role = json['role'];
  }
  String? id;
  String? username;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['role'] = role;
    return map;
  }

}