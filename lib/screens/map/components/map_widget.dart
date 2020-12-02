import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class MapsHome extends StatefulWidget {
  @override
  _MapsHomeState createState() => _MapsHomeState();
}

class _MapsHomeState extends State<MapsHome> {
  Marker _marker;
  Timer _timer;
  int _markerIndex = 2;

  MapController mapController;
  double rotation = 0.0;
  double zoom = 8.0;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _marker = _markers[_markerIndex];
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      // setState(() {
      //   _marker = _markers[_markerIndex];
      //   _markerIndex = (_markerIndex + 1) % _markers.length;

      //   mapController.move(_marker.point, 15);
      // });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      mapController: mapController,
      options: new MapOptions(
        center: new LatLng(-23.533773, -46.625290),
        zoom: this.zoom,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/giulianop/ckhwc42dq17fh19nypm109cql/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoiZ2l1bGlhbm9wIiwiYSI6ImNraHdhY3dsMzFwaWcycG5wZ2JuY25mMnIifQ.Q6HdilgVsNvbP2LVB8eVfA',
            'id': 'mapbox.mapbox-streets-v8',
          },
          // For example purposes. It is recommended to use
          // TileProvider with a caching and retry strategy, like
          // NetworkTileProvider or CachedNetworkTileProvider
          tileProvider: NonCachingNetworkTileProvider(),
        ),
        MarkerLayerOptions(markers: <Marker>[_marker]),
      ],
    );
  }

  List<Marker> _markers = [
    Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(51.5, -0.09),
      builder: (ctx) => Container(
        child: FlutterLogo(),
      ),
    ),
    Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(53.3498, -6.2603),
      builder: (ctx) => Container(
        child: FlutterLogo(),
      ),
    ),
    Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(48.8566, 2.3522),
      builder: (ctx) => Container(
        child: FlutterLogo(),
      ),
    ),
  ];
}
