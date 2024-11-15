class Account {
  final String account_id;
  final String email;
  final String password;
  final String is_active;

  Account({
    required this.account_id,
    required this.email,
    required this.password,
    required this.is_active,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': account_id,
      'email': email,
      'password': password,
      'isActive': is_active,
    };
  }
}
