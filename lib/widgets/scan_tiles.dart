import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String type;
  const ScanTiles({@required this.type});

  @override
  Widget build(BuildContext context) {
    //dentro de builConte use usa true // dentro de un metodo sera false
    final scanListProvider = Provider.of<ScanListProvider>(
      context,
    );
    final scans = scanListProvider.scans;
    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, i) => Dismissible(
              key: UniqueKey(), //key unique by default
              onDismissed: (DismissDirection direction) {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteScanById(scans[i].id);
              },
              background: Container(
                color: Colors.red,
              ),
              child: ListTile(
                leading: Icon(
                  this.type == 'http' ? Icons.home_outlined : Icons.map,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scans[i].valor),
                subtitle: Text(scans[i].id.toString()),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
                onTap: () => launchURL(context, scans[i]),
              ),
            ));
  }
}
