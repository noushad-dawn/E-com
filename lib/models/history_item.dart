class HistoryItem {
  final double totalAmount;
  final bool status;
  final String? date;
  HistoryItem(
      {required this.totalAmount, required this.status, required this.date});

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      totalAmount: json['totalAmount'],
      status: json['status'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAmount': totalAmount,
      'status': status,
      'date': date,
    };
  }
}
