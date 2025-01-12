class Bill {
  final int? id;
  final int clientId;
  final List<BillItem> items;
  final double totalAmount;
  final double discount;
  final DateTime date;
  final String? notes;

  Bill({
    this.id,
    required this.clientId,
    required this.items,
    required this.totalAmount,
    this.discount = 0.0,
    required this.date,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'totalAmount': totalAmount,
      'discount': discount,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'],
      clientId: map['clientId'],
      items: [], // Items need to be loaded separately
      totalAmount: map['totalAmount'],
      discount: map['discount'],
      date: DateTime.parse(map['date']),
      notes: map['notes'],
    );
  }
}

class BillItem {
  final int? id;
  final int billId;
  final int? serviceId;
  final String serviceName;
  final double price;
  final String? description;

  BillItem({
    this.id,
    required this.billId,
    this.serviceId,
    required this.serviceName,
    required this.price,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'billId': billId,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'price': price,
      'description': description,
    };
  }

  factory BillItem.fromMap(Map<String, dynamic> map) {
    return BillItem(
      id: map['id'],
      billId: map['billId'],
      serviceId: map['serviceId'],
      serviceName: map['serviceName'],
      price: map['price'],
      description: map['description'],
    );
  }
}
