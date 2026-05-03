class Kos {
  final String id;
  final String name;
  final String location;
  final double price;
  final double rating;
  final String image;
  final String imageUrl;
  final String description;
  final List<String> facilities;
  final String type;

  Kos({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.image,
    String? imageUrl,
    this.description = '',
    this.facilities = const [],
    this.type = '',
  }) : imageUrl = imageUrl ?? image;
}
