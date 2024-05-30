class CategoryModel {
  String? name;
  String? desc;
  String? photo;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? categoryId;

  CategoryModel({
    this.name,
    this.desc,
    this.photo,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.categoryId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
        desc: json["desc"],
        photo: json["photo"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        categoryId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "photo": photo,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "id": categoryId,
      };
}
