part of 'trendingnow_bloc.dart';

@immutable
abstract class TrendingnowState {}

class TrendingnowInitial extends TrendingnowState {}
class TrendingnowblocLoading extends TrendingnowState {}
class TrendingnowblocLoaded extends TrendingnowState {
}
class TrendingnowblocError extends TrendingnowState {}
