class Payment {
  final String paymentId;
  final int numberCreditBought;
  final String typePayment;
  final double totalPrice;
  final String userId;

  Payment({
    required this.paymentId,
    required this.numberCreditBought,
    required this.typePayment,
    required this.totalPrice,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'paymentId': paymentId,
      'numberCreditBought': numberCreditBought,
      'typePayment': typePayment,
      'totalPrice': totalPrice,
      'userId': userId,
    };
  }
}
