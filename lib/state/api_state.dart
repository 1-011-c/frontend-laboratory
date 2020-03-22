import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class APIState extends Equatable {

  @override
  List<Object> get props => [];

}

/// User will scan barcode
class APIWaiting extends APIState {}

/// Send barcode data to server
class APISending extends APIState {}

/// The barcode was successfully sent to the server
class APISent extends APIState {}

/// There was an error while sending data to server
class APIError extends APIState {
  final String message;

  APIError({
    @required this.message
  });
}