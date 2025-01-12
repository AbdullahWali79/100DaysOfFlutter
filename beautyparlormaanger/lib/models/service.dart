class Service {
  final int? id;
  final String name;
  final double price;
  final String description;
  final String category;

  Service({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      category: map['category'],
    );
  }
}
