part of 'apply_coupans_bloc.dart';

@immutable
abstract class ApplyCoupansState {}

class ApplyCoupansInitial extends ApplyCoupansState {}
class ApplyCoupansblocLoading extends ApplyCoupansState {}
class ApplyCoupansblocLoaded extends ApplyCoupansState {
}
class ApplyCoupansblocError extends ApplyCoupansState{}