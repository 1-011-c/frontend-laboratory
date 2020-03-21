import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labor_scanner/api/API.dart';
import 'package:labor_scanner/event/api_event.dart';
import 'package:labor_scanner/state/api_state.dart';

class APIBloc extends Bloc<APIEvent, APIState> {

  @override
  Stream<APIState> mapEventToState(APIEvent event) async* {
    if (event is UpdateAPIEvent) {
      yield APISending();

      if (API.update(event.url, event.infected)) { yield APISent(); }
      else { yield APIError(); }
    }
  }

  @override
  APIState get initialState => APIWaiting();

}