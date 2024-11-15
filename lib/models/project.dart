class Project {
  String? idProject;
  String nameProject;
  String field;
  String note;
  String type;
  String location;
  String language;
  String certificate;
  String date;
  String salaryType;
  num minSalary;
  num maxSalary;
  bool isChecked;

  Project({
    this.idProject,
    required this.nameProject,
    required this.field,
    required this.note,
    required this.type,
    required this.location,
    required this.language,
    required this.certificate,
    required this.date,
    required this.salaryType,
    required this.minSalary,
    required this.maxSalary,
    required this.isChecked,
  });

  Map<String, dynamic> toMap() {
    return {
      'nameProject': nameProject,
      'field': field,
      'note': note,
      'type': type,
      'location': location,
      'language': language,
      'certificate': certificate,
      'date': date,
      'salaryType': salaryType,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'isChecked': isChecked,
    };
  }
}
