class Language {
  final String languageId;
  final String language;

  Language({
    required this.languageId,
    required this.language,
  });

  Map<String, dynamic> toMap() {
    return {
      'languageId': languageId,
      'language': language,
    };
  }
}
