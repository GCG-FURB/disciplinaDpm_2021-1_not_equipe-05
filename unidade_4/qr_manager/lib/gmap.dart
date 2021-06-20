import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatefulWidget {
  String lat;
  String long;
  GMap({Key key, lat, long}) : super(key: key) {
    this.lat = lat;
    this.long = long;
  }

  @override
  _GMapState createState() => _GMapState(lat:this.lat, long: this.long);
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();
  bool _showMapStyle = false;
  String lat;
  String long;

  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;

  _GMapState({String lat, String long}){
    _setLatLong(lat, long);
  }

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setPolygons(this.lat, this.long);
    _setPolylines(this.lat, this.long);
    _setCircles(this.lat, this.long);
  }

  void _setLatLong(String lat, String long){
    this.lat = lat;
    this.long = long;
  }

  void _setMarkerIcon() async {
    _markerIcon =
        await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/noodle_icon.png');
  }

  void _toggleMapStyle() async {
    String style = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');

    if (_showMapStyle) {
      _mapController.setMapStyle(style);
    } else {
      _mapController.setMapStyle(null);
    }
  }

  void _setPolygons(String lat, String long) {
    List<LatLng> polygonLatLongs = List<LatLng>();
    polygonLatLongs.add(LatLng(double.parse(lat), double.parse(long)));
    polygonLatLongs.add(LatLng(double.parse(lat), double.parse(long)));
    polygonLatLongs.add(LatLng(double.parse(lat), double.parse(long)));
    polygonLatLongs.add(LatLng(double.parse(lat), double.parse(long)));

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points: polygonLatLongs,
        fillColor: Colors.white,
        strokeWidth: 1,
      ),
    );
  }

  void _setPolylines(String lat, String long) {
    List<LatLng> polylineLatLongs = List<LatLng>();
    polylineLatLongs.add(LatLng(double.parse(lat), double.parse(long)));
    polylineLatLongs.add(LatLng(double.parse(lat), double.parse(long)));
    polylineLatLongs.add(LatLng(double.parse(lat), double.parse(long)));
    polylineLatLongs.add(LatLng(double.parse(lat), double.parse(long)));

    _polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        points: polylineLatLongs,
        color: Colors.purple,
        width: 1,
      ),
    );
  }

  void _setCircles(String lat, String long) {
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(double.parse(lat), double.parse(long)),
          radius: 1000,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(102, 51, 153, .5)),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(double.parse(this.lat), double.parse(this.long)),
            infoWindow: InfoWindow(
              title: "San Francsico",
              snippet: "An Interesting city",
            ),
            icon: _markerIcon),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mapa')),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(this.lat), double.parse(this.long)),
              zoom: 12,
            ),
            markers: _markers,
            polygons: _polygons,
            polylines: _polylines,
            circles: _circles,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          // Container(
          //   alignment: Alignment.bottomCenter,
          //   padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
          //   child: Text("Coding with Curry"),
          // )
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Increment',
      //   child: Icon(Icons.map),
      //   onPressed: () {
      //     setState(() {
      //       _showMapStyle = !_showMapStyle;
      //     });
      //
      //     _toggleMapStyle();
      //   },
      // ),
    );
  }
}
