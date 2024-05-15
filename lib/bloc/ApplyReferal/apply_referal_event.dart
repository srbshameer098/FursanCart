part of 'apply_referal_bloc.dart';

@immutable
abstract class ApplyReferalEvent {}
class FetchReferal extends ApplyReferalEvent{
  final String referalCode;
  FetchReferal({required this.referalCode});
  }