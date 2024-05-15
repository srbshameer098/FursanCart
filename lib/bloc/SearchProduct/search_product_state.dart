part of 'search_product_bloc.dart';

@immutable
abstract class SearchProductState {}

class SearchProductInitial extends SearchProductState {}
class SearchProductblocloading extends SearchProductState{}
class SearchProductblocloaded extends SearchProductState{}
class SearchProductblocerror extends SearchProductState{}