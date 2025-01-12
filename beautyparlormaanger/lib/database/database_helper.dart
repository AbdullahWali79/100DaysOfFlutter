import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/service.dart';
import '../models/client.dart';
import '../models/bill.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('beauty_parlor.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE services(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        description TEXT,
        category TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE clients(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        address TEXT,
        appointmentDateTime TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE bills(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        clientId INTEGER NOT NULL,
        totalAmount REAL NOT NULL,
        discount REAL DEFAULT 0,
        date TEXT NOT NULL,
        notes TEXT,
        FOREIGN KEY (clientId) REFERENCES clients (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE bill_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        billId INTEGER NOT NULL,
        serviceId INTEGER,
        serviceName TEXT NOT NULL,
        price REAL NOT NULL,
        description TEXT,
        FOREIGN KEY (billId) REFERENCES bills (id),
        FOREIGN KEY (serviceId) REFERENCES services (id)
      )
    ''');
  }

  // Service CRUD operations
  Future<int> insertService(Service service) async {
    final db = await database;
    return await db.insert('services', service.toMap());
  }

  Future<List<Service>> getAllServices() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('services');
    return List.generate(maps.length, (i) => Service.fromMap(maps[i]));
  }

  // Client CRUD operations
  Future<int> insertClient(Client client) async {
    final db = await database;
    return await db.insert('clients', client.toMap());
  }

  Future<List<Client>> getAllClients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('clients');
    return List.generate(maps.length, (i) => Client.fromMap(maps[i]));
  }

  // Bill CRUD operations
  Future<int> insertBill(Bill bill, List<BillItem> items) async {
    final db = await database;
    int billId = 0;
    
    await db.transaction((txn) async {
      billId = await txn.insert('bills', bill.toMap());
      
      for (var item in items) {
        final billItem = BillItem(
          billId: billId,
          serviceId: item.serviceId,
          serviceName: item.serviceName,
          price: item.price,
          description: item.description,
        );
        await txn.insert('bill_items', billItem.toMap());
      }
    });
    
    return billId;
  }

  Future<List<Bill>> getBillsByDate(DateTime date) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    
    final List<Map<String, dynamic>> maps = await db.query(
      'bills',
      where: "date LIKE ?",
      whereArgs: ['$dateStr%'],
    );
    
    return List.generate(maps.length, (i) => Bill.fromMap(maps[i]));
  }

  // Close database
  Future close() async {
    final db = await database;
    db.close();
  }
}
