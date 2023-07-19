class AvailableBank {
  final String name;
  final String bankCode;
  final String status;
  final int fee;
  final int queue;

  AvailableBank({
    required this.name,
    required this.bankCode,
    required this.status,
    required this.fee,
    required this.queue,
  });

  factory AvailableBank.fromJson(Map<String, dynamic> json) {
    return AvailableBank(
      name: json["name"],
      bankCode: json["bank_code"],
      status: json["status"],
      fee: json["fee"],
      queue: json["queue"],
    );
  }

  static List<AvailableBank> fromJsonList(List list) {
    return list.map((item) => AvailableBank.fromJson(item)).toList();
  }
}
