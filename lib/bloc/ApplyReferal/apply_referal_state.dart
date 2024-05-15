part of 'apply_referal_bloc.dart';

@immutable
abstract class ApplyReferalState {}

class ApplyReferalInitial extends ApplyReferalState {}
class ApplyReferalsblocLoading extends ApplyReferalState {}
class ApplyReferalblocLoaded extends ApplyReferalState {
}
class ApplyReferalblocError extends ApplyReferalState{}