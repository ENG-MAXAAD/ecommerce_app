class BannerModels {
  String? id;
  String? name;
  String? desc;
  List<String>? photo;
  int? v;

  BannerModels({
    this.id,
    this.name,
    this.desc,
    this.photo,
    this.v,
  });

  factory BannerModels.fromJson(Map<String, dynamic> json) => BannerModels(
        id: json["_id"],
        name: json["name"],
        desc: json["desc"],
        photo: json["photo"] == null
            ? []
            : List<String>.from(json["photo"]!.map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "desc": desc,
        "photo": photo == null ? [] : List<dynamic>.from(photo!.map((x) => x)),
        "__v": v,
      };
}
