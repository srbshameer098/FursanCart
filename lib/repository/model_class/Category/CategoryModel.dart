class CategoryModel {
  CategoryModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.name, 
      this.description, 
      this.image, 
      this.subCategories,});

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    description = json['description'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(Image1.fromJson(v));
      });
    }
    if (json['subCategories'] != null) {
      subCategories = [];
      json['subCategories'].forEach((v) {
        subCategories?.add(SubCategories.fromJson(v));
      });
    }
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? description;
  List<Image1>? image;
  List<SubCategories>? subCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['name'] = name;
    map['description'] = description;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    if (subCategories != null) {
      map['subCategories'] = subCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
  static List<CategoryModel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => CategoryModel.fromJson(value)).toList();
  }
}

class SubCategories {
  SubCategories({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.name, 
      this.description, 
      this.catId, 
      this.image,});

  SubCategories.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    description = json['description'];
    catId = json['catId'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(Image1.fromJson(v));
      });
    }
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? description;
  String? catId;
  List<Image1>? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['name'] = name;
    map['description'] = description;
    map['catId'] = catId;
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