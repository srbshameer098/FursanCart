part of 'selectedbestoffer_bloc.dart';

@immutable
abstract class SelectedbestofferEvent {}
class FetchSelectedBestoffer extends SelectedbestofferEvent{
   String bannersubid;
   FetchSelectedBestoffer({required this.bannersubid});
}