part of 'subcategoryselecteditem_bloc.dart';

@immutable
abstract class SubcategoryselecteditemState {}

class SubcategoryselecteditemInitial extends SubcategoryselecteditemState {}
class SubCategoryselecteditemblocLoading extends SubcategoryselecteditemState {}
class SubCategoryselecteditemblocLoaded extends SubcategoryselecteditemState {
}
class SubCategoryselecteditemblocError extends SubcategoryselecteditemState{}