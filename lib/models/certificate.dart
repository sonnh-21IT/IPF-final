class Certificate {
  final String? certificateId;
  final String imgCheck;
  final String idLanguage;
  final String idUser;
  final int status;
  final String level;

  Certificate( {
    this.certificateId,
    required this.imgCheck,
    required this.idLanguage,
    required this.idUser,
    required this.status,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'imgCheck': imgCheck,
      'idLanguage': idLanguage,
      'idUser': idUser,
      'status': status,
      'level': level,
    };
  }
}
