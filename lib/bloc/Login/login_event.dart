part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class FetchLoginApi extends LoginEvent{
  final String email;
  final String password;
  FetchLoginApi(this.email,this.password);


}
