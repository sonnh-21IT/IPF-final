class Position {
  final String userId;
  final double longitude;
  final double latitude;

  Position({
    required this.userId,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}