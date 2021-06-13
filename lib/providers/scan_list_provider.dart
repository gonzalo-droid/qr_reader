import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String typeSelecced = 'http';

  newScan(String value) async {
    final newScan = new ScanModel(valor: value);
    final id = await DBProvider.db.newScan(newScan);

    newScan.id = id;

  //solo se add a list cuando es del mismo tipo, y asi se actualiza na UI
    if (this.typeSelecced == newScan.tipo) {
      this.scans.add(newScan);
      //notificar a todos que se hizo un cambio
      notifyListeners();
    }
  }
}
