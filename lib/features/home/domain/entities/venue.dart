class Venue {
  final String id;
  final String name;
  final String location;
  final String description;
  final double price;
  final List<String> images;

  Venue({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.images,
  });

  @override
  String toString() {
    return 'Venue{id: $id, name: $name, location: $location, description: $description, price: $price, images: $images}';
  }
}