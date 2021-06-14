import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async  {
  final url = scan.valor.toString();
  print(scan.valor);
  if (scan.tipo == 'http') {
    if (await canLaunch(url)) {
      final res = await canLaunch(url);
      print(res);
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments:  scan);
  }
}
