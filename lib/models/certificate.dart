class Certificate {
  final String certificateId;
  final String name;

  Certificate({
    required this.certificateId,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'certificateId': certificateId,
      'name': name,
    };
  }
}
