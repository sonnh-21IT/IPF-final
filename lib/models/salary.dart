class Salary {
  final String salaryId;
  final String projectId;
  final double min;
  final double max;
  final String typ;

  Salary({
    required this.salaryId,
    required this.projectId,
    required this.min,
    required this.max,
    required this.typ,
  });

  Map<String, dynamic> toMap() {
    return {
      'salaryId': salaryId,
      'projectId': projectId,
      'min': min,
      'max': max,
      'typ': typ,
    };
  }
}
