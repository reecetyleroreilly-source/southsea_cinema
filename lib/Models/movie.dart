class MovieModel {
  final String id;
  final String name;
  final String description;
  final String date;
  final double price;
  final String imagePath;

  const MovieModel({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.price,
    required this.imagePath,
  });

  String get formattedPrice {
    final String formattedValue = price.toStringAsFixed(2);
    return '£$formattedValue';
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final String id = json['id'] as String;
    final String name = json['name'] as String;
    final String description = json['description'] as String;
    final String date = json['date'] as String;
    final num priceNumber = json['price'] as num;
    final double price = priceNumber.toDouble();
    final String imagePath = json['imagePath'] as String;

    return MovieModel(
        id: id,
        name: name,
        description: description,
        date: date,
        price: price,
        imagePath: imagePath
      );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>(
  //     'id': id,
  //     'name': name,
  //     'description': description,
  //     'date': date,
  //     'price': price,
  //     'imagePath': imagePath
  //   );
  //   return data;
  // }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date,
      'price': price,
      'imagePath': imagePath,
    };
  }


  //Movie(this.id, this.name, this.description, this.imagePath)
}
