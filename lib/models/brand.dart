import 'dart:convert';
import 'package:shoes/services/database_service.dart'; // Assuming DatabaseService is in this path

class Brand {
  final int? id; 
  final String name;
  final String description;

  Brand({
    this.id,
    required this.name,
    required this.description,
  });

  // Convert a Brand into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each brand when using the print statement.
  @override
  String toString() => 'Brand(id: $id, name: $name, description: $description)';

  // Method to update the brand in the database
  Future<void> update() async {
    final db = await DatabaseService().database;
    await db.update(
      'brands',
      this.toMap(),
      where: 'id = ?',
      whereArgs: [this.id],
    );
  }

  // Method to delete the brand from the database
  Future<void> delete() async {
    final db = await DatabaseService().database;
    await db.delete(
      'brands',
      where: 'id = ?',
      whereArgs: [this.id],
    );
  }
}
