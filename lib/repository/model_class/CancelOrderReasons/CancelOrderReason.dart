class CancelOrderReason {
  CancelOrderReason({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.reason,});

  CancelOrderReason.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    reason = json['reason'];
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['reason'] = reason;
    return map;
  }
  static List<CancelOrderReason> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => CancelOrderReason.fromJson(value)).toList();
  }}
