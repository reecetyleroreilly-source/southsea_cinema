class Movie {
  final String id;
  final String name;
  final String description;
  final String date;
  final double price;
  final String imagePath;

  const Movie({
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

  //Movie(this.id, this.name, this.description, this.imagePath)
}
