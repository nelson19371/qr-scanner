

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:location/location.dart';

class ScanButton extends StatefulWidget {
 

  @override
  State<ScanButton> createState() => _ScanButtonState();
  Location location = new Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.granted;
  LocationData _locationData = LocationData.fromMap({});
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: ()async{

        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false,ScanMode.QR);

        //  String barcodeScanRes = '16678099-33';

        // Validar si el rut no tiene digitos extras
        List<String> searchKeywords = List<String>.generate(
          barcodeScanRes.length,
          (index) => barcodeScanRes[index]);

          if(barcodeScanRes[barcodeScanRes.length - 3]=='-'){
            searchKeywords.removeLast();
            barcodeScanRes = searchKeywords.join("");
            final now = DateTime.now();
            print('${barcodeScanRes} ${now}');
          }else{
            final now = DateTime.now();
            print('${searchKeywords} ${now}');
          }
        getLocation();

      }
      );
  }
  void getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      print('${_locationData.altitude}');
      print('${_locationData.latitude}${_locationData.longitude}');
      print('${_locationData.longitude}');
    });
}
}