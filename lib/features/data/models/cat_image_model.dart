class CatImageModel {
  final String id;
  final String url;
  final double width;
  final double height;

  CatImageModel({required this.id, required this.url, required this.width, required this.height});

  factory CatImageModel.fromJson(Map<String, dynamic> json) =>
    CatImageModel(id: json["id"],
        url:json["url"],
        width: json["width"],
        height: json["height"]);


}