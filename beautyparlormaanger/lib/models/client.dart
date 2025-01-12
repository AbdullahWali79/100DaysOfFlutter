class Client {
  final int? id;
  final String name;
  final String phone;
  final String address;
  final DateTime? appointmentDateTime;

  Client({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    this.appointmentDateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'appointmentDateTime': appointmentDateTime?.toIso8601String(),
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      appointmentDateTime: map['appointmentDateTime'] != null
          ? DateTime.parse(map['appointmentDateTime'])
          : null,
    );
  }
}
