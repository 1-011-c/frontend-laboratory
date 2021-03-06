import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labor_scanner/bloc/api_bloc.dart';
import 'package:labor_scanner/bloc/settings_bloc.dart';
import 'package:labor_scanner/event/settings_event.dart';
import 'package:labor_scanner/model/corona_test_case.dart';
import 'package:labor_scanner/pages/settings_page.dart';
import 'package:labor_scanner/service/api_service.dart';
import 'package:labor_scanner/state/settings_state.dart';
import 'package:labor_scanner/widgets/loading.dart';
import 'package:labor_scanner/widgets/status_indicator_widget.dart';

import 'pages/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(),
          ),
          BlocProvider<APIBloc>(
            create: (context) => APIBloc(),
          )
        ],
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            context.bloc<SettingsBloc>().add(GetSettingsEvent());
            if(state is UnknownTestingSettingsState) {
              return SettingsPage();
            }

            return FeatureDiscovery(
              child: MainPage(settingsState: state),
            );
          },
        ),
      )
    );
  }
}
