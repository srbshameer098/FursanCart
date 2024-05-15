part of 'selectedbestoffer_bloc.dart';

@immutable
abstract class SelectedbestofferState {}

class SelectedbestofferInitial extends SelectedbestofferState {}
class SelectedBestofferblocLoading extends SelectedbestofferState{}
class SelectedBestofferblocLoaded extends SelectedbestofferState {
}
class SelectedBestofferblocError extends SelectedbestofferState {}

