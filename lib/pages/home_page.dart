

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/adress_page.dart';
import 'package:qr_reader/pages/maps_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(child: Text("Historial")),
        actions: [
          IconButton(icon: Icon(Icons.delete_forever), onPressed: (){
            final uiProvider = Provider.of<UiProvider>(context, listen:  false);
            final currentIndex = uiProvider.selectedMenuOpt;
            String type = (currentIndex==0) ? 'geo':'http';

            final scanListProvider = Provider.of<ScanListProvider>(context, listen:  false);
            scanListProvider.deleteByType(type);
          })
        ],
      ),
      
      body: _HomePageBody(),
     bottomNavigationBar: CustomNavigatorBar(),
     floatingActionButton: ScanButton(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //obtener select menu opt desde provider

    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;
    //TODO: TEMPORAL TEST DB
    // DBProvider.db.getScanById(4).then((value) => print(value.valor));
    // DBProvider.db.getAllScans().then(print);
    // DBProvider.db.deleteAllScan().then(print);
    
    final scanListProvider = Provider.of<ScanListProvider>(context, listen:  false);

    switch(currentIndex){
      case 0:
        scanListProvider.getScansByType('geo');
        return MapsPage();
      case 1:
        scanListProvider.getScansByType('http');
        return AdressPage();
      default:
        return MapsPage();
    }
  }
}