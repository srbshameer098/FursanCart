part of 'update_user_bloc.dart';

@immutable
abstract class UpdateUserState {}

class UpdateUserInitial extends UpdateUserState {}
class UpdateUserblocLoading extends UpdateUserState {}
class UpdateUserblocLoaded extends UpdateUserState {
}
class UpdateUserblocError extends UpdateUserState {}
