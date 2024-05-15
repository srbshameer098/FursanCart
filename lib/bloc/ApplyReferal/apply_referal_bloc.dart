
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/ApplyReferal/apply_referal_api.dart';
import '../../repository/model_class/Referral/Referral.dart';

part 'apply_referal_event.dart';
part 'apply_referal_state.dart';

class ApplyReferalBloc extends Bloc<ApplyReferalEvent, ApplyReferalState> {
  late  Referral referral;
  ApplyReferalApi applyReferalApi =ApplyReferalApi();
  ApplyReferalBloc() : super(ApplyReferalInitial()) {
    on<FetchReferal>((event, emit) async{
      emit(ApplyReferalsblocLoading());
      try {
        referral=await applyReferalApi.applyreferal(referalCode: event.referalCode);

        emit(ApplyReferalblocLoaded());
      } catch (e) {
        print("*****$e");
        emit(ApplyReferalblocError());
      }
      // TODO: implement event handler
    });
  }
}
