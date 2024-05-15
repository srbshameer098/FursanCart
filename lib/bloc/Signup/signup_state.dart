part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {


}


class SignupblocInitial extends SignupState {}
class SignupblocLoading extends SignupState {}
class SignupblocLoaded extends SignupState {
  final Usermodel data;
  SignupblocLoaded(this.data);
}
class SignupblocError extends SignupState {}
