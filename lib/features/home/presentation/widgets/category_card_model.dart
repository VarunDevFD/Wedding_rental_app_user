class CategoryCardModel {
  final String name;
  final String imagePath;
  final String route;

  CategoryCardModel({
    required this.name,
    required this.imagePath,
    required this.route,
  });
}

final List<CategoryCardModel> categories = [
  CategoryCardModel(name: 'Camera', imagePath: 'assets/category/camera.png', route: '/cameraList'),
  CategoryCardModel(name: 'Decoration', imagePath: 'assets/category/decoration.png', route: '/decorationList'),
  CategoryCardModel(name: 'Dress', imagePath: 'assets/category/dress.png', route: '/dressList'),
  CategoryCardModel(name: 'Footwear', imagePath: 'assets/category/footwear.png', route: '/footwearList'),
  CategoryCardModel(name: 'Jewelry', imagePath: 'assets/category/jewelry.png', route: '/jewelryList'),
  CategoryCardModel(name: 'Sound', imagePath: 'assets/category/sound.png', route: '/soundList'),
  CategoryCardModel(name: 'Venue', imagePath: 'assets/category/venue.png', route: '/venueList'),
  CategoryCardModel(name: 'Vehicle', imagePath: 'assets/category/vehicle.png', route: '/vehicleList'),
];
