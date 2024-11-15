class Credit {
  final String creditId;
  final String userId;
  final String sum;

  Credit({
    required this.creditId,
    required this.userId,
    required this.sum,
  });

  Map<String, dynamic> toMap() {
    return {
      'creditId': creditId,
      'userId': userId,
      'Sum': sum,
    };
  }
}
