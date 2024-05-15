part of 'update_password_bloc.dart';

@immutable
abstract class UpdatePasswordEvent {}
class FetchUpdatePassword extends  UpdatePasswordEvent{
  final String oldPassword;
  final String newPassword;
  FetchUpdatePassword({required this.oldPassword,required  this.newPassword});
}