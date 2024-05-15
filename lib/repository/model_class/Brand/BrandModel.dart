class BrandModel {
  BrandModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.name, 
      this.image,});

  BrandModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
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
  List<Image1>? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['name'] = name;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    return map;
  }
  static List<BrandModel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => BrandModel.fromJson(value)).toList();
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