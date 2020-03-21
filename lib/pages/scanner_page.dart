import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:sensors/sensors.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {

  DateTime stamp = DateTime.now();

  bool _lifted = false;
  bool _scanning = false;

  String _barcode = '';

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) { _checkSettled(); });
  }

  void _checkLifted() {
    print('check lifted');
    gyroscopeEvents.listen((GyroscopeEvent event) {
      // print(event);
      if (event.x.abs() > 0.5 || event.y.abs() > 0.5 || event.z.abs() > 0.5 ) {
        //print('Lifted: z -> ${event.z.abs()}, y -> ${event.y.abs()}, z -> ${event.z.abs()}');
        stamp = DateTime.now();
        setState(() {
          _lifted = true;
          _scanning = true;
        });
      }
    });
  }

  void _checkSettled() {
    print('Check Settled');
    var now = DateTime.now();
    print(now.difference(stamp));
    if(now.difference(stamp) >= Duration(milliseconds: 4000)) {
      print('Settled');
      setState(() {
        _lifted = false;
        _scanning = false;
      });
    }
  }

  _qrCallback(String code) {
    setState(() {
      _scanning = false;
      _barcode = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkLifted();
    return Container(
      decoration: BoxDecoration(
          color: Colors.green
      ),
      child: _scanning ?
      Center(
        child: SizedBox(
          height: 1000,
          width: 500,
          child: QRBarScannerCamera(
            onError: (context, error) => Text(
              error.toString(),
              style: TextStyle(color: Colors.red),
            ),
            qrCodeCallback: (code) {
              _qrCallback(code);
            },
          ),
        ),
      ) : Center(child: Text(_barcode)),
    );
  }
}
