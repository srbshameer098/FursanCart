part of 'post_favourates_bloc.dart';

@immutable
abstract class PostFavouratesEvent {}
class FetchAddToFavourates extends PostFavouratesEvent{
  final productid;
  FetchAddToFavourates({required this.productid});
}