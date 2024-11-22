class Certificate {
  final String? certificateId;
  final String imgCheck;
  final String idLanguage;
  final String idUser;
  final int status;

  Certificate( {
    this.certificateId,
    required this.imgCheck,
    required this.idLanguage,
    required this.idUser,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'certificateId': certificateId,
      'imgCheck': imgCheck,
      'idLanguage': idLanguage,
      'idUser': idUser,
      'status': status,
    };
  }
}
