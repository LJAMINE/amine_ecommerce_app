class Category {
  String? name;
  String? photo;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Category({this.name, this.photo, this.sId, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['photo'] = photo;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
