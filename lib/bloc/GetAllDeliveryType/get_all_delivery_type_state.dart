part of 'get_all_delivery_type_bloc.dart';

@immutable
abstract class GetAllDeliveryTypeState {}

class GetAllDeliveryTypeInitial extends GetAllDeliveryTypeState {}
class GetAllDeliveryTypeblocloading extends GetAllDeliveryTypeState {}
class GetAllDeliveryTypeblocloaded extends GetAllDeliveryTypeState {}
class GetAllDeliveryTypeblocerror extends GetAllDeliveryTypeState {}