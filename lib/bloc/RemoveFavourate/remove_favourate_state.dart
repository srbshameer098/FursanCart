part of 'remove_favourate_bloc.dart';

@immutable
abstract class RemoveFavourateState {}

class RemoveFavourateInitial extends RemoveFavourateState {}
class RemoveFavourateblocLoading extends RemoveFavourateState {}
class RemoveFavourateblocLoaded extends RemoveFavourateState {
}
class RemoveFavourateblocError extends RemoveFavourateState{}