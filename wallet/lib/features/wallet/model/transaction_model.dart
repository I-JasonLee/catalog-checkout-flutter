class TransactionModel {
  final String transactionId;
  final int amount;
  final String status;
  final String date;

  TransactionModel({
    required this.transactionId,
    required this.amount,
    required this.status,
    required this.date,
  });
}