class Bank {
  final String accountNumber;
  final String bankCode;
  final String bankName;
  final String id;

  Bank({
    required this.accountNumber,
    required this.bankCode,
    required this.id,
    required this.bankName,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      bankName: json["bankName"],
      accountNumber: json["accountNumber"],
      bankCode: json["bankCode"],
      id: json["_id"],
    );
  }

  static List<Bank> fromJsonList(List list) {
    return list.map((item) => Bank.fromJson(item)).toList();
  }
}
