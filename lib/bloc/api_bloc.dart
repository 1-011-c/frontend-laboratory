import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labor_scanner/event/api_event.dart';
import 'package:labor_scanner/model/corona_test_case.dart';
import 'package:labor_scanner/service/api_service.dart';
import 'package:labor_scanner/state/api_state.dart';

class APIBloc extends Bloc<APIEvent, APIState> {

  static const API_ERROR_TIME = 2;

  @override
  Stream<APIState> mapEventToState(APIEvent event) async* {
    if (event is UpdateAPIEvent) {
      yield APISending();

      final CoronaTestCase apiResult = await APIService.update(event.url, event.infected);

      if (apiResult != null) {
        yield APISent();
      }
      else {
        yield APIError();
      }
    } else if (event is RequestCompleteEvent) {
      yield APIWaiting();
    }
  }

  @override
  APIState get initialState => APIWaiting();

}