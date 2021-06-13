import 'dart:io'; //Directory

import 'package:path/path.dart'; //el flutter por defecto "join"
import 'package:path_provider/path_provider.dart'; //getApplicationDocumentsDirectory
import 'package:sqflite/sqflite.dart'; //Database

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

//SINGLETON

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  // DBProvider._() constructor privado
  DBProvider._();

  //lectura a la base datos es asincrona
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    //path de donde se almacenaremos la db
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path =
        join(documentsDirectory.path, 'ScanDB.db' //extension de slqlite
            );
    print(path);

    //creacion de db
    return await openDatabase(path,
        version:
            2, //aumentar segun los cambios que se realizen, para que vuelva a ejecutar la creacion
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute(''' 
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
    });
  }

  // Future<int> newScanRaw(ScanModel newScan) async{

  //   final id = newScan.id;
  //   final tipo = newScan.tipo;
  //   final valor = newScan.valor;
  //   //verifica la db
  //   final db = await database;
  //   final res = await db.rawInsert('''
  //     INSERT INTO Scans(id,tipo,valor)
  //       VALUES($id , '$tipo', '$valor')
  //   ''');
  //   return res;
  // }

  Future<int> newScan(ScanModel newScan) async {
    //verifica la db
    final db = await database;

    //res id del last data inserted
    final res = await db.insert('Scans', newScan.toJson());

    print(res);
    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;

    //argumentos son relacionados de manera posicional
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    //retorna una lista

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;

    //argumentos son relacionados de manera posicional
    final res = await db.query('Scans');
    //retorna una lista

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;

    //argumentos son relacionados de manera posicional
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$type'
    ''');
    //retorna una lista

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;

    final res = await db.update('Scans', newScan.toJson(),
        where: 'id =  ?', whereArgs: [newScan.id]);

    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;

    final res = await db.delete('Scans',
        where: 'id =  ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;

    final res = await db.delete('Scans');

    return res;
  }


}
