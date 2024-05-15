part of 'update_user_bloc.dart';

@immutable
abstract class UpdateUserEvent {}
class FetchUpdateUserName extends UpdateUserEvent{
  final username;
  FetchUpdateUserName({required this.username});

}
class FetchUpdateEmail extends UpdateUserEvent{
  final email;
  FetchUpdateEmail({required this.email});

}
class FetchUpdatePhone extends UpdateUserEvent{
  final phone;
  FetchUpdatePhone({required this.phone});

}