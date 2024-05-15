class SubCategoryModel {
  SubCategoryModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.name, 
      this.description, 
      this.catId, 
      this.image,});

  SubCategoryModel.fromJson(dynamic json) {
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
  static List<SubCategoryModel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => SubCategoryModel.fromJson(value)).toList();
  }
}

class Image1 {
  Image1({
      this.url,});

  Image1.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }

}