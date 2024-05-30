class ProductCategoryModel {
  String? id;
  String? name;
  String? desc;
  int? price;
  String? category;
  bool? isTrending;
  List<String>? photos;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryModel(
        id: json["_id"],
        name: json["name"],
        desc: json["desc"],
        price: json["price"],
        category: json["category"],
        isTrending: json["isTrending"],
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "desc": desc,
        "price": price,
        "category": category,
        "isTrending": isTrending,
        "photos":
            photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
  ProductCategoryModel({
    this.id,
    this.name,
    this.desc,
    this.price,
    this.category,
    this.isTrending,
    this.photos,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
}
