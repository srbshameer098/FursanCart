part of 'get_all_orders_bloc.dart';

@immutable
abstract class GetAllOrdersState {}

class GetAllOrdersInitial extends GetAllOrdersState {}
class GetAllOrdersblocloading extends GetAllOrdersState {}
class GetAllOrdersblocloaded extends GetAllOrdersState {}
class GetAllOrdersblocerror extends GetAllOrdersState {}