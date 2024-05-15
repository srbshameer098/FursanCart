part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class SignupblocInitial extends LoginState {}
class SignupblocLoading extends LoginState {}
class SignupblocLoaded extends LoginState {
  final Usermodel data;
  SignupblocLoaded(this.data);
}
class SignupblocError extends LoginState {}
