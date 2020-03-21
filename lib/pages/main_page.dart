import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labor_scanner/bloc/api_bloc.dart';
import 'package:labor_scanner/pages/scanner_page.dart';
import 'package:labor_scanner/state/api_state.dart';
import 'package:labor_scanner/widgets/loading.dart';
import 'package:labor_scanner/widgets/status_indicator_widget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<APIBloc, APIState>(
        builder: (context, state) {
          if(state is APIWaiting) {
            return ScannerPage();
          }
          else if (state is APISent) {
            return Center(
              child: StatusIndicatorWidget.success(),
            );
          }
          else if (state is APIError) {
            return Center(
              child: StatusIndicatorWidget.error(),
            );
          }

          return Center(
            child: LoadingWidget(),
          );
        },
      )
    );
  }
}
