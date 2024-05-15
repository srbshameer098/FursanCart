part of 'brand_selection_bloc.dart';

@immutable
abstract class BrandSelectionState {}

class BrandSelectionInitial extends BrandSelectionState {}
class SelectedBrandblocLoading extends BrandSelectionState {}
class SelectedBrandblocLoaded extends BrandSelectionState {
}
class SelectedBrandblocError extends BrandSelectionState{}
class SectionExpired extends BrandSelectionState{}