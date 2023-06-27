class Bank {
  final String accountNumber;
  final String bankCode;
  final String id;

  Bank({
    required this.accountNumber,
    required this.bankCode,
    required this.id,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      accountNumber: json["accountNumber"],
      bankCode: json["bankCode"],
      id: json["_id"],
    );
  }

  static List<Bank> fromJsonList(List list) {
    return list.map((item) => Bank.fromJson(item)).toList();
  }
}
