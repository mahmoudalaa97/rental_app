class Property {
  Property({
    required this.name,
    required this.location,
    required this.type,
    required this.pricing,
    required this.per,
    required this.id,
    required this.image,
  });

  final String name;
  final String location;
  final String type;

  final double pricing;
  final String per;
  final int id;
  final String image;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Property &&
        other.name == name &&
        other.location == location &&
        other.type == type &&
        other.pricing == pricing &&
        other.per == per &&
        other.id == id &&
        other.image == image;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        location.hashCode ^
        type.hashCode ^
        pricing.hashCode ^
        per.hashCode ^
        id.hashCode ^
        image.hashCode;
  }
}

