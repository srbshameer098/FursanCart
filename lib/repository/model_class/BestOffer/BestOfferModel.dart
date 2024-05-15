class BestOfferModel {
  BestOfferModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.bannerTitle, 
      this.tags, 
      this.categoryId, 
      this.productId, 
      this.subCategoryId, 
      this.type, 
      this.banner, 
      this.category, 
      this.subCategory, 
      this.product,});

  BestOfferModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bannerTitle = json['bannerTitle'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    categoryId = json['categoryId'];
    productId = json['productId'];
    subCategoryId = json['subCategoryId'];
    type = json['type'];
    if (json['banner'] != null) {
      banner = [];
      json['banner'].forEach((v) {
        banner?.add(Banner.fromJson(v));
      });
    }
    category = json['Category'];
    subCategory = json['subCategory'];
    product = json['Product'];
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? bannerTitle;
  List<String>? tags;
  dynamic categoryId;
  dynamic productId;
  dynamic subCategoryId;
  String? type;
  List<Banner>? banner;
  dynamic category;
  dynamic subCategory;
  dynamic product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['bannerTitle'] = bannerTitle;
    map['tags'] = tags;
    map['categoryId'] = categoryId;
    map['productId'] = productId;
    map['subCategoryId'] = subCategoryId;
    map['type'] = type;
    if (banner != null) {
      map['banner'] = banner?.map((v) => v.toJson()).toList();
    }
    map['Category'] = category;
    map['subCategory'] = subCategory;
    map['Product'] = product;
    return map;
  }
  static List<BestOfferModel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => BestOfferModel.fromJson(value)).toList();
  }
}

class Banner {
  Banner({
      this.url,});

  Banner.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }

}