part of 'update_password_bloc.dart';

@immutable
abstract class UpdatePasswordState {}

class UpdatePasswordInitial extends UpdatePasswordState {}
class UpdatePasswordblocLoading extends UpdatePasswordState {}
class UpdatePasswordblocLoaded extends UpdatePasswordState {
}
class UpdatePasswordblocError extends UpdatePasswordState {}