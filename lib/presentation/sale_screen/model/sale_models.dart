
class Sale {
  final String invoiceNumber;
  final String date;
  final String customer;
  final String billingName;
  final String phoneNumber;
  final double totalAmount;

  Sale({
    required this.invoiceNumber,
    required this.date,
    required this.customer,
    required this.billingName,
    required this.phoneNumber,
    required this.totalAmount,
  });

  // Convert a Sale instance to a map
  Map<String, dynamic> toMap() {
    return {
      'invoiceNumber': invoiceNumber,
      'date': date,
      'customer': customer,
      'billingName': billingName,
      'phoneNumber': phoneNumber,
      'totalAmount': totalAmount,
    };
  }

  // Create a Sale instance from a map
  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      invoiceNumber: map['invoiceNumber'] ?? '',
      date: map['date'] ?? '',
      customer: map['customer'] ?? '',
      billingName: map['billingName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      totalAmount: (map['totalAmount'] ?? 0.0).toDouble(),
    );
  }
}
