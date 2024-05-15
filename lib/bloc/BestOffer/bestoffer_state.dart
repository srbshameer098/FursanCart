part of 'bestoffer_bloc.dart';

@immutable
abstract class BestofferState {}

class BestofferInitial extends BestofferState {}
class BestofferblocLoading extends  BestofferState {}
class BestofferblocLoaded extends BestofferState {
}
class BestofferblocError extends BestofferState {}
