

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../repository/api/Update_Password/update_password_api.dart';
import '../../repository/model_class/UpdatePassword/UpdatePasswordModel.dart';


part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
 late  UpdatePasswordModel updatePasswordModel;
 UpdatePasswordApi updatePasswordApi=UpdatePasswordApi();
  UpdatePasswordBloc() : super(UpdatePasswordInitial()) {
    on<FetchUpdatePassword>((event, emit)async {
      emit(UpdatePasswordblocLoading());
      try {

        updatePasswordModel = await updatePasswordApi.updatepassword(oldPassword: event.oldPassword, newPassword: event.newPassword);

        emit(UpdatePasswordblocLoaded());
      } catch (e) {
        print('*****$e');
        emit(UpdatePasswordblocError());
      }

      // TODO: implement event handler
    });
  }
}
