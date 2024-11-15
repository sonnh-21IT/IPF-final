class Role {
  final String roleId;
  final String role;

  Role({
    required this.roleId,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'roleId': roleId,
      'role': role,
    };
  }
}
