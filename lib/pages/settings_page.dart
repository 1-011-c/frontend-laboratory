import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labor_scanner/bloc/settings_bloc.dart';
import 'package:labor_scanner/event/settings_event.dart';
import 'package:labor_scanner/model/settings_status.dart';

class SettingsPage extends StatefulWidget {

  final SettingsStatus status;

  SettingsPage({
    this.status = SettingsStatus.POSITIVE
  });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  SettingsStatus _status;

  @override
  void initState() {
    setState(() {
      _status = widget.status;
    });
    super.initState();
  }

  void _changedSettings(SettingsStatus value) {
    setState(() {
      _status = value;
    });
  }

  void _updateSettings(BuildContext context) {
    print('Updating');
    context.bloc<SettingsBloc>().add(UpdateSettingsEvent(status: _status));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einstellungen'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Diese App bestätigt einen...', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            ListTile(
              title: const Text('Positiv Fall'),
              leading: Radio(
                value: SettingsStatus.POSITIVE,
                groupValue: _status,
                onChanged: _changedSettings,
              ),
              onTap: () => _changedSettings(SettingsStatus.POSITIVE),
            ),
            ListTile(
              title: const Text('Negativ Fall'),
              leading: Radio(
                value: SettingsStatus.NEGATIVE,
                groupValue: _status,
                onChanged: _changedSettings,
              ),
              onTap: () => _changedSettings(SettingsStatus.NEGATIVE),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () => _updateSettings(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}