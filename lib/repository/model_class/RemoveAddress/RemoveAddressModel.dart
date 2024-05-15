class RemoveAddressModel {
  RemoveAddressModel({
      this.msg,});

  RemoveAddressModel.fromJson(dynamic json) {
    msg = json['msg'];
  }
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    return map;
  }

}