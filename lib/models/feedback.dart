class Feedback {
  final String feedbackId;
  final String content;
  final int rated;
  final String userId;
  final String projectId;
  final String userIdTake;

  Feedback({
    required this.feedbackId,
    required this.content,
    required this.rated,
    required this.userId,
    required this.projectId,
    required this.userIdTake,
  });

  Map<String, dynamic> toMap() {
    return {
      'feedbackId': feedbackId,
      'content': content,
      'rated': rated,
      'userId': userId,
      'projectId': projectId,
      'userIdTake': userIdTake,
    };
  }
}
