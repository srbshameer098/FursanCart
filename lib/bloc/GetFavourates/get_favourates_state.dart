part of 'get_favourates_bloc.dart';

@immutable
abstract class GetFavouratesState {}

class GetFavouratesInitial extends GetFavouratesState {}
class GetFavouratesblocloading extends GetFavouratesState{}
class GetFavouratesblocloaded extends GetFavouratesState{}
class GetFavouratesblocerror extends GetFavouratesState{}