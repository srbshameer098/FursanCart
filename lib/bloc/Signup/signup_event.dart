part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {

}
class FetchSignupApi extends SignupEvent{
  final String email;
  final String username;
  final String password;
  FetchSignupApi(this.email,this.username,this.password);


}