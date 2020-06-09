import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbAddressManager {
  Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "ss.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE address(id INTEGER PRIMARY KEY autoincrement, name TEXT, city TEXT)",

        );
      } );
    }
  }

  Future<int> insertAddress(Address address) async {
    await openDb();
    return await _database.insert('address', address.toMap());
  }

  Future<List<Address>> getAddressList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('address');
    return List.generate(maps.length, (i) {
      return Address(
          id: maps[i]['id'], name: maps[i]['name'], city: maps[i]['city']);
    });
  }

  Future<int> updateAddress(Address address) async {
    await openDb();
    return await _database.update('address', address.toMap(),
        where: "id = ?", whereArgs: [address.id]);
  }

  Future<void> deleteAddress(int id) async {
    await openDb();
    await _database.delete(
        'address',
        where: "id = ?", whereArgs: [id]
    );
  }
}

class Address {
  int id;
  String name;
  String city;
  Address({@required this.name, @required this.city, this.id});
  Map<String, dynamic> toMap() {
    return {'name': name, 'city': city };
  }
}