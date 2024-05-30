class Product {
  final String? name;
  final String? desc;
  final int? price;
  final Map<String, dynamic>? category;
  final bool? isTrending;
  final List<String>? photos;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Product({
    this.name,
    this.desc,
    this.price,
    this.category,
    this.isTrending,
    this.photos,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"] ?? '',
        desc: json["desc"] ?? '',
        price: json["price"] ?? 0,
        category: json["category"] ?? '',
        isTrending: json["isTrending"] ?? false,
        photos: json["photos"] != null
            ? List<String>.from(json["photos"].map((x) => x))
            : [],
        id: json["_id"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "price": price,
        "category": category,
        "isTrending": isTrending,
        "photos": photos ?? [],
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
