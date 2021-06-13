
import 'dart:io';

import 'package:path/path.dart'; //el flutter por defecto "join"
import 'package:path_provider/path_provider.dart';
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
  Future<Database> get database async{
    if(_database != null ) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async{

    //path de donde se almacenaremos la db
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(
      documentsDirectory.path,
      'ScanDB.db' //extension de slqlite
    );
    print(path);


    //creacion de db
    return await openDatabase(
      path,
      version: 1, //aumentar segun los cambios que se realizen, para que vuelva a ejecutar la creacion
      onOpen: (db){},
      onCreate: (Database db, int version) async{
        await db.execute(''' 
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');



      }
    );


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

    Future<int> newScanRaw(ScanModel newScan) async{

    
    //verifica la db
    final db = await database;
    
    final res = await db.insert('Scans',newScan.toJson());
    return res;
  }

}