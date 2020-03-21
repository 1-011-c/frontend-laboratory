import 'package:equatable/equatable.dart';

abstract class APIState extends Equatable {

  @override
  List<Object> get props => [];

}

class APIWaiting extends APIState {}
class APISending extends APIState {}
class APISent extends APIState {}
class APIError extends APIState {}