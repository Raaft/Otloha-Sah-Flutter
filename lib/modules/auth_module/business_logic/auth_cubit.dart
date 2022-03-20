import 'dart:convert';

import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/modules/auth_module/data/data_source/login_servise.dart';
import 'package:flutter_base/modules/home/data/models/user/user_prfile.dart';
import 'package:flutter_base/modules/home/data/profile_servise/profile_servises.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/UserModel.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  Future<void> userLogIn({@required email, @required password}) async {
    emit(LogInLoadingState());
    await Auth()
        .userLogIn(
      email: email,
      password: password,
    )!
        .then((value) async {
      userModel = UserModel.fromJson(value!.data);
      CacheHelper.saveData(key: 'token', value: userModel!.accessToken);
      CacheHelper.saveData(key: 'refresh', value: userModel!.refreshToken);
      print(
          'UserModel is ===========> $userModel user model token= ${userModel!.accessToken} ');

      await saveUsers();

      emit(LogInSuccessState());
    }).catchError((error) {
      //  print('emit error=========');

      emit(LogInErrorState(error.errors));
    });
  }



  saveUsers() async {
    UserProfile? user = await ProfileServ().myProfile();

    if (user != null) {
      CacheHelper.saveData(
          key: userProfileLogined, value: jsonEncode(userModel!.toJson()));
      if (user.favoriteTeacher != null && user.favoriteTeacher! > 0) {
        var teacher =
            await ProfileServ().userProfile(user.favoriteTeacher ?? 0);
        if (teacher != null) {
          CacheHelper.saveData(
              key: favTeacher, value: jsonEncode(teacher.toJson()));
        }
      }
    }
  }


  Future<void> userRegister(
      {email, username, password1, password2, birthdate, phone, gender}) async {
    emit(RegisterLoadingState());
    await Auth()
        .userRegister(
            birthdate: birthdate,
            email: email,
            gender: gender,
            password1: password1,
            password2: password2,
            phone: phone,
            username: username)
        .then((value) async {
      userModel = UserModel.fromJson(value.data);

      CacheHelper.saveData(key: 'token', value: userModel!.accessToken);
      token = userModel!.accessToken.toString();
      print(
          'UserModel is ===========> $userModel user model token= ${userModel!.accessToken} ');
      await saveUsers();
      emit(RegisterSuccessState());
    }).catchError((error) {
      // print('in cubit' + .toString());
      // print();
      // print('emit error=========');
      emit(RegisterErrorState(error.errors));
    });
  }

  Future<void> userLogOut() async {
    emit(LogOutLoadingState());
    await Auth().logOut().then((value) {
      CacheHelper.clearData(key: 'token');
      print('LogOut Done');
      emit(LogOutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LogOutErrorState(error.toString()));
      return error;
    });
  }

  Future<void> changeIsLogin({required bool isLog}) async {
    await CacheHelper.saveData(key: 'isLogin', value: isLog);

    isLogin = isLog;
    print('Is Login Booooooooooool $isLogin');
    emit(ChangeIsLogInStateState());
  }

}
