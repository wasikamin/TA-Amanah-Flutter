class Loan {
  String loanId;
  String userId;
  String purpose;
  String borrowingCategory;
  int amount;
  int tenor;
  int yieldReturn;
  String status;
  int totalFunding;
  String borrowerId;
  String name;
  String email;
  String paymentSchema;
  Loan({
    required this.loanId,
    required this.userId,
    required this.purpose,
    required this.borrowingCategory,
    required this.amount,
    required this.tenor,
    required this.yieldReturn,
    required this.status,
    required this.totalFunding,
    required this.borrowerId,
    required this.name,
    required this.email,
    required this.paymentSchema,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      loanId: json['loanId'],
      userId: json['userId'],
      purpose: json['purpose'],
      borrowingCategory: json['borrowingCategory'],
      amount: json['amount'],
      tenor: json['tenor'],
      yieldReturn: json['yieldReturn'],
      status: json['status'],
      totalFunding: json['totalFunding'],
      borrowerId: json['borrowerId'],
      name: json['name'],
      email: json['email'],
      paymentSchema: json['paymentSchema'],
    );
  }
}
