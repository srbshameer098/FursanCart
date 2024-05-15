part of 'brand_bloc.dart';

@immutable
abstract class BrandState {}

class BrandInitial extends BrandState {}
class ChooseBrandblocLoading extends BrandState {}
class ChooseBrandblocLoaded extends BrandState {
}
class ChooseBrandblocError extends BrandState {}
