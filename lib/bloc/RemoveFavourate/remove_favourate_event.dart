part of 'remove_favourate_bloc.dart';

@immutable
abstract class RemoveFavourateEvent {}
class FetchRemoveFavourate extends RemoveFavourateEvent{
  final productwishlistid;
  FetchRemoveFavourate({required this.productwishlistid});
}