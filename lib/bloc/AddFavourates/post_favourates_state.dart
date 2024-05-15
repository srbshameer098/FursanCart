part of 'post_favourates_bloc.dart';

@immutable
abstract class PostFavouratesState {}

class PostFavouratesInitial extends PostFavouratesState {}
class PostToFavourateblocLoading extends PostFavouratesState {}
class PostToFavourateblocLoaded extends PostFavouratesState {
}
class PostToFavourateblocError extends PostFavouratesState{}