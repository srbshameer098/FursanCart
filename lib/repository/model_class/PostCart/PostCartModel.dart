class PostCartModel {
  PostCartModel({
      this.msg,});

  PostCartModel.fromJson(dynamic json) {
    msg = json['msg'];
  }
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    return map;
  }

}