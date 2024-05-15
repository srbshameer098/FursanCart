part of 'get_user_details_bloc.dart';

@immutable
abstract class GetUserDetailsState {}

class GetUserDetailsInitial extends GetUserDetailsState {}
class GetUserDetailsblocloading extends GetUserDetailsState{}
class GetUserDetailsblocloaded extends GetUserDetailsState{}
class GetUserDetailsblocerror extends GetUserDetailsState{}