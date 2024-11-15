class Notification {
  final String notificationId;
  final String title;
  final String content;
  final String typeNotification;
  final String userId;

  Notification({
    required this.notificationId,
    required this.title,
    required this.content,
    required this.typeNotification,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'title': title,
      'content': content,
      'typeNotification': typeNotification,
      'userId': userId,
    };
  }
}
