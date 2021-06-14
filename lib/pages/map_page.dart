import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  // const MapPage({ Key? key }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    final CameraPosition pintInit = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.5,
      tilt: 50, //inclinación
    );

    //markerts
    Set<Marker> markets = new Set<Marker>();
    markets.add(new Marker(
        markerId: MarkerId('geo-location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.location_searching_sharp),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  target: scan.getLatLng(),
                  zoom: 17.5,
                  tilt: 50,
                )));
              })
        ],
      ),
      body: GoogleMap(
        // myLocationButtonEnabled: false,
        mapType: mapType,
        initialCameraPosition: pintInit,

        markers: markets, //markadores
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: (){
          

          setState(() {
            (mapType==MapType.normal)?mapType=MapType.satellite:mapType=MapType.normal;  
          });
        },
      ),
    );
  }
}
