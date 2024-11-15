class Field {
  final String fieldId;
  final String field;

  Field({
    required this.fieldId,
    required this.field,
  });

  Map<String, dynamic> toMap() {
    return {
      'fieldId': fieldId,
      'field': field,
    };
  }
}
