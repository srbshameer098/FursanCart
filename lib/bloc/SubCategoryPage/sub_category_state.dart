part of 'sub_category_bloc.dart';

@immutable
abstract class SubCategoryState {}

class SubCategoryInitial extends SubCategoryState {}
class SubCategoryblocLoading extends SubCategoryState {}
class SubCategoryblocLoaded extends SubCategoryState {
}
class SubCategoryblocError extends SubCategoryState{}