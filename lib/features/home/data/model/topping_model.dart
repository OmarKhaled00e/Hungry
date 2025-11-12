class ToppingModel {
  final String name;
  final int id;
  final String image;

  ToppingModel({required this.name, required this.id, required this.image});
  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    return ToppingModel(
      name: json['name'],
      id: json['id'],
      image: json['image'],
    );
  }
}
