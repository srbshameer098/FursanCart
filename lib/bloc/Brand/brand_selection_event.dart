part of 'brand_selection_bloc.dart';

@immutable
abstract class BrandSelectionEvent {}
class FetchSelectedBrand extends BrandSelectionEvent{
  late  String brandid;
  FetchSelectedBrand({required this.brandid});
}