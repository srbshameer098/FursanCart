

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../repository/api/Patch_User/update_user_api.dart';
import '../../repository/model_class/UpdateUser/UpdateUserModel.dart';


part 'update_user_event.dart';

part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  late UpdateUserModel updateUserModel;
  UpdateUserApi updateUserApi = UpdateUserApi();

  UpdateUserBloc() : super(UpdateUserInitial()) {
    on<FetchUpdateUserName>((event, emit) async {
      emit(UpdateUserblocLoading());
      try {

        updateUserModel = await updateUserApi.updateusername(username: event.username);

        emit(UpdateUserblocLoaded());
      } catch (e) {
        print('*****$e');
        emit(UpdateUserblocError());
      }
      // TODO: implement event handler
    });
    on<FetchUpdateEmail>((event, emit) async {
      emit(UpdateUserblocLoading());
      try {

        updateUserModel = await updateUserApi.updateemail(email: event.email);

        emit(UpdateUserblocLoaded());
      } catch (e) {
        print('*****$e');
        emit(UpdateUserblocError());
      }
      // TODO: implement event handler
    });
    on<FetchUpdatePhone>((event, emit) async {
      emit(UpdateUserblocLoading());
      try {

        updateUserModel = await updateUserApi.updatephone(phone: event.phone);

        emit(UpdateUserblocLoaded());
      } catch (e) {
        print('*****$e');
        emit(UpdateUserblocError());
      }
      // TODO: implement event handler
    });
  }
}
