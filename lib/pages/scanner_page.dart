import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:labor_scanner/bloc/api_bloc.dart';
import 'package:labor_scanner/bloc/settings_bloc.dart';
import 'package:labor_scanner/event/api_event.dart';
import 'package:labor_scanner/model/corona_test_case.dart';
import 'package:labor_scanner/state/settings_state.dart';
import 'package:sensors/sensors.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {

  DateTime stamp = DateTime.now();

  bool _scanning = false;

  StreamSubscription<GyroscopeEvent> gyroscopeEventsSubscription;

  String _barcode = '';

  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _checkSettled());
    _checkLifted();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    gyroscopeEventsSubscription.cancel();
  }

  void _checkLifted() {
    gyroscopeEventsSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      if (event.x.abs() > 0.5 || event.y.abs() > 0.5 || event.z.abs() > 0.5 ) {
        stamp = DateTime.now();
        setState(() {
          _scanning = true;
        });
      }
    });
  }

  void _checkSettled() {
    var now = DateTime.now();
    if(now.difference(stamp) >= Duration(milliseconds: 4000)) {
      setState(() {
        _scanning = false;
      });
    }
  }

  _qrCallback(String code, SettingsState state) {
    if (state is PositiveTestingSettingsState) {
      context.bloc<APIBloc>().add(UpdateAPIEvent(
          url: code,
          infected: CoronaStatus.POSITIVE)
      );
    }
    else {
      context.bloc<APIBloc>().add(UpdateAPIEvent(
          url: code,
          infected: CoronaStatus.NEGATIVE)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        var bgc = state is PositiveTestingSettingsState ? Colors.blue : Colors.amber;
        return Container(
          decoration: BoxDecoration(
              color: bgc
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
                  _qrCallback(code, state);
                },
              ),
            ),
          ) : Center(child: Text(_barcode)),
        );
      },
    );
  }
}
