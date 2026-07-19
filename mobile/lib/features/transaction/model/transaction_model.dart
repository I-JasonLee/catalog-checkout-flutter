class TransactionModel {
  final String transactionId;
  final int amount;
  final String status;

  TransactionModel({
    required this.transactionId,
    required this.amount,
    required this.status,
  });
}