class Language {
  final String? languageId;
  final String language;

  Language({
    this.languageId,
    required this.language,
  });

  Map<String, dynamic> toMap() {
    return {
      'language': language,
    };
  }
}
