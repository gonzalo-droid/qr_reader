import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {

        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BFF', 'Cancelar', false, ScanMode.QR);

        // final barcodeScanRes = 'https://fernando-herrera.com';
      
        // final barcodeScanRes = 'geo:-6.788691,-79.835690';
      
      
        if(barcodeScanRes == '-1'){
          return; //se cancelo la accion
        }

        // listen:  false para q no se redibuje el metodo
        final scanListProvider = Provider.of<ScanListProvider>(context, listen:  false);
        
        final newScan = await scanListProvider.newScan(barcodeScanRes);
        
        launchURL(context, newScan);
      },
    );
  }
}
