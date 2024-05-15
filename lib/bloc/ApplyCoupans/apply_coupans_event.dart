part of 'apply_coupans_bloc.dart';

@immutable
abstract class ApplyCoupansEvent {}
class FetchCoupans extends ApplyCoupansEvent{
  final String code;
  FetchCoupans({required this.code});
}