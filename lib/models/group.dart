class Group {
  final String groupId;
  final String name;

  Group({
    required this.groupId,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'name': name,
    };
  }
}
