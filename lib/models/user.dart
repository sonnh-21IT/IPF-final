class Users {
  final String? userId;
  final String accountId;
  final String fullName;
  final String email;
  final String address;
  final String phone;
  final String biography;
  final bool status;
  final String roleId;
  final String birthday;
  final String languageId;
  final String imagePath;
  final String fieldId;
  late final int credit;

  Users({
    this.userId,
    required this.accountId,
    required this.fullName,
    required this.email,
    required this.address,
    required this.phone,
    required this.biography,
    required this.status,
    required this.roleId,
    required this.birthday,
    required this.languageId,
    required this.imagePath,
    required this.fieldId,
    required this.credit,
  });



  Map<String, dynamic> toMap() {
    return {
      'accountId': accountId,
      'fullName': fullName,
      'email': email,
      'address': address,
      'phone': phone,
      'biography': biography,
      'status': status,
      'roleId': roleId,
      'birthday': birthday,
      'languageId': languageId,
      'imagePath': imagePath,
      'fieldId': fieldId,
      'credit': credit,
    };
  }

  @override
  String toString() {
    return 'Users{userId: $userId, accountId: $accountId, fullName: $fullName, email: $email, address: $address, phone: $phone, biography: $biography, status: $status, roleId: $roleId, birthday: $birthday, languageId: $languageId, imagePath: $imagePath, fieldId: $fieldId, credit: $credit}';
  }
}
