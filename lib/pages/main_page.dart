import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labor_scanner/bloc/api_bloc.dart';
import 'package:labor_scanner/bloc/settings_bloc.dart';
import 'package:labor_scanner/event/api_event.dart';
import 'package:labor_scanner/event/settings_event.dart';
import 'package:labor_scanner/model/settings_status.dart';
import 'package:labor_scanner/pages/scanner_page.dart';
import 'package:labor_scanner/state/api_state.dart';
import 'package:labor_scanner/state/settings_state.dart';
import 'package:labor_scanner/widgets/loading.dart';
import 'package:labor_scanner/widgets/status_indicator_widget.dart';

class MainPage extends StatefulWidget {

  final SettingsState settingsState;

  MainPage({
    @required this.settingsState
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final assetsAudioPlayer = AssetsAudioPlayer();

  Timer _timer;

  void _complete(BuildContext context, final Duration duration) {
    assetsAudioPlayer.play();
    _timer = Timer(duration, () => context.bloc<APIBloc>().add(RequestCompleteEvent()));
  }

  @override
  void dispose() {
    _timer.cancel();
    assetsAudioPlayer.stop();
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bgc = widget.settingsState is PositiveTestingSettingsState ? Colors.blue : Colors.amber;
    final GlobalKey scaffoldKey = GlobalKey();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: bgc,
        title: Text('Scanner'),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              context.bloc<SettingsBloc>().add(UpdateSettingsEvent(status: SettingsStatus.UNKNOWN));
            },
          )
        ],
      ),
      body: BlocBuilder<APIBloc, APIState>(
        builder: (ccontext, state) {
          if(state is APIWaiting) {
            return ScannerPage(settingsState: widget.settingsState);
          }
          else if (state is APISent) {
            assetsAudioPlayer.open('assets/audios/success.mp3');
            _complete(ccontext, const Duration(milliseconds: 2500));
            return StatusIndicatorWidget.success(backgroundColor: bgc);
          }
          else if (state is APIError) {
            assetsAudioPlayer.open('assets/audios/error.mp3');
            _complete(ccontext, const Duration(milliseconds: 5000));
            return StatusIndicatorWidget.error(errorMessage: state.message, backgroundColor: bgc);
          }

          return Container(
            color: bgc,
            child: Center(
              child: LoadingWidget(),
            ),
          );
        },
      )
    );
  }
}
