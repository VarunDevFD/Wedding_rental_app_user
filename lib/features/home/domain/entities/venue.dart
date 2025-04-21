class Venue {
  final String? name;
  final int? price;
  final int? sdPrice;
  final List<String>? location;
  final List<String>? images;
  final String? description;
  final int? capacity;
  final String? duration;
  final String? venueType;
  final String? phoneNumber;
  final String? date;
  final List<String>? facilities;
  final bool? available;
  final bool? privacyPolicy;

  Venue({
    this.name,
    this.price,
    this.sdPrice,
    this.location,
    this.images,
    this.description,
    this.capacity,
    this.duration,
    this.venueType,
    this.phoneNumber,
    this.date,
    this.facilities,
    this.available,
    this.privacyPolicy = false,
  });
}
