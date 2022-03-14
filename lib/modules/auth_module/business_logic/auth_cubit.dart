import 'package:dio/dio.dart';
import 'package:flutter_base/modules/auth_module/data/data_source/login_servise.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/UserModel.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

   Future <Response>?userLogIn({@required email, @required password}) {
    emit(LogInSuccessLoadingState());
    Auth().userLogIn(email: email, password: password).then((value) {
      userModel = UserModel.fromJson(value.data);
      print('UserModel is ===========> $userModel');
      emit(LogInSuccessState());
      return value;
    }).catchError((error) {
      print(error.toString());
      emit(LogInErrorState(error.toString()));
      return error;
    });
  }

  Future<Response>? userRegister(
      {@required email, @required password, @required name, @required phone}) {
    emit(RegisterLoadingState());
    Auth()
        .userRegister(
            email: email, password: password, name: name, phone: phone)
        .then((value) {
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
    return null;
  }
}
