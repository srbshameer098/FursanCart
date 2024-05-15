part of 'sub_category_bloc.dart';

@immutable
abstract class SubCategoryEvent {}
class FetchSubCategory extends SubCategoryEvent{
  final String categoryId;
  FetchSubCategory({required this.categoryId});

}