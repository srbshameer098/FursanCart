part of 'search_product_bloc.dart';

@immutable
abstract class SearchProductEvent {}
class FetchSearchProduct extends SearchProductEvent{
  final String keyword;
  FetchSearchProduct({required this.keyword});
}