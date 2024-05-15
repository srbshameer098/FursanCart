part of 'subcategoryselecteditem_bloc.dart';

@immutable
abstract class SubcategoryselecteditemEvent {}
class FetchSubCategorySelectedItem extends SubcategoryselecteditemEvent{
final subcategoryid;
FetchSubCategorySelectedItem({required this.subcategoryid});
}