import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();

  /** lista de marcadores **/
  Set<Marker> _marcadores = {};

  /** lista de poligons **/
  Set<Polygon> _polygons = {};

  /** lista de polilines **/
  Set<Polyline> _polyline = {};

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(-23.562436, -46.655005),
            zoom: 16,
            tilt: 0,
            bearing: 270)));
  }

  _carregarMarcadores() {
    /*  Set<Marker> marcadoresLocal = {};
  /** cria marcador **/
    Marker marcadorShopping = Marker(
        markerId: MarkerId("marcador-shopping"),
        position: LatLng(-23.563370, -46.652923),
        infoWindow: InfoWindow(title: "Shopping Cidade São Paulo"),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        onTap: () {
          print("Shopping clicado!!");
        }
        //rotation: 45
        );

    Marker marcadorCartorio = Marker(
        markerId: MarkerId("marcador-cartorio"),
        position: LatLng(-23.562868, -46.655874),
        infoWindow: InfoWindow(title: "12 Cartório de notas"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () {
          print("Cartório clicado!!");
        });

    marcadoresLocal.add(marcadorShopping);
    marcadoresLocal.add(marcadorCartorio);

    setState(() {
      _marcadores = marcadoresLocal;
    });
    Set<Polygon> listaPolygons = {};
    Polygon polygon1 = Polygon(
        polygonId: PolygonId('polygon1'),
        fillColor: Colors.transparent,
        strokeColor: Colors.red,
        strokeWidth: 10,
        points: [
          LatLng(-15.9084298, -47.7732767),
          LatLng(-15.9063868, -47.7764307),
          LatLng(-15.9048188, -47.7751327),
          LatLng(-15.9073368, -47.7722147)
        ],
        consumeTapEvents: true,
        onTap: () {
          print("Clicou na area");
        });
    listaPolygons.add(polygon1);
    setState(() {
      _polygons = listaPolygons;
    });*/
    Set<Polyline> listaPolyline = {};
    Polyline polyline = Polyline(
        polylineId: PolylineId('polyline'),
        color: Colors.red,
        width: 10,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: [
          LatLng(-15.9098088,-47.7691377),
          LatLng(-15.9059398,-47.7742337),
         // LatLng(-15.9048188, -47.7751327),
        ]);
    listaPolyline.add(polyline);
    setState(() {
      _polyline = listaPolyline;
    });
  }

  _recuperaLozalizacao() async{
    Position position = await Geolocator().getCurrentPosition(
      /** precisao **/
      desiredAccuracy: LocationAccuracy.high
    );
    print('Localizacao' + position.toString());
  }

  @override
  void initState() {
    super.initState();
   // _carregarMarcadores();
    _recuperaLozalizacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapas e geolocalização"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done), onPressed: _movimentarCamera),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          //mapType: MapType.hybrid,
          //mapType: MapType.none,
          //mapType: MapType.satellite,
          //mapType: MapType.terrain,
          //-23.562436, -46.655005
          initialCameraPosition: CameraPosition(
              target: LatLng(-15.9084298, -47.7732767), zoom: 17),
          onMapCreated: _onMapCreated,
          markers: _marcadores,
          polygons: _polygons,
          polylines: _polyline,
        ),
      ),
    );
  }
}
