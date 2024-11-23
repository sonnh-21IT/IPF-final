class Field {
  final String? fieldId;
  final String field;

  Field({
    this.fieldId,
    required this.field,
  });

  Map<String, dynamic> toMap() {
    return {
      'field': field,
    };
  }
}
