import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String typeSelecced = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = new ScanModel(valor: value);
    final id = await DBProvider.db.newScan(newScan);

    newScan.id = id;

    //solo se add a list cuando es del mismo tipo, y asi se actualiza na UI
    if (this.typeSelecced == newScan.tipo) {
      this.scans.add(newScan);
      //notificar a todos que se hizo un cambio
      notifyListeners();
    }

    return newScan;
  }

  getScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans]; //asginar un nuevo listado
    notifyListeners();
  }

  getScansByType(String type) async {
    final scans = await DBProvider.db.getScansByType(type);
    this.scans = [...scans]; //asginar un nuevo listado
    this.typeSelecced = type;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScanById(id);
    getScansByType(this.typeSelecced);
  }

   deleteByType(String type) async {
    await DBProvider.db.deleteByType(type);
    this.getScansByType(type);
  }
}
