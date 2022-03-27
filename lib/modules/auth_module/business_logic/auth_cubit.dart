import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/data_source/data_source.dart';
import 'package:flutter_base/modules/auth_module/data/data_source/login_servise.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data_source/models/home_models/LogInErrorModel.dart';
import '../../../data_source/models/home_models/user_prfile.dart';
import '../data/models/UserModel.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  bool isLogin = true;

  LogInErrorModel? logInErrorModel;

  thenAuth(value) {
    userModel = UserModel.fromJson(value.data);
    CacheHelper.saveData(key: 'token', value: userModel!.accessToken);
    token = userModel!.accessToken.toString();
    isLogin = true;
    changeIsLogin(islog: true);
    print(
        'UserModel is ===========> $userModel user model token= ${userModel!.accessToken} ');
    emit(ThenAuthState());
  }

  UserProfile proFile = UserProfile();
  Future saveProfile() async {
    try {
      proFile = UserProfile.fromJson(
          jsonDecode(await CacheHelper.getData(key: userProfileLogined)));
      favTeacherProFile = UserProfile.fromJson(
          jsonDecode(await CacheHelper.getData(key: favTeacher)));
    } catch (e) {
      print('no user login');
    }
  }

  Future<void> userLogIn({@required email, @required password}) async {
    emit(LogInLoadingState());

    try {
      Response response = await Auth().userLogIn(
        email: email,
        password: password,
      );
      await thenAuth(response);
      await saveUsers();
      emit(LogInSuccessState());
    } on InvalidData catch (error) {
      emit(LogInErrorState(error.errors!));
    }

    print(await Auth().getProfile());
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
      thenAuth(value);
      await saveUsers();
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  saveUsers() async {
    UserProfile? user = await DataSource().myProfile();
    try {
      if (user != null) {
        CacheHelper.saveData(
            key: userProfileLogined, value: jsonEncode(userModel!.toJson()));
        if (user.favoriteTeacher != null && user.favoriteTeacher! > 0) {
          var teacher =
              await DataSource().userProfile(user.favoriteTeacher ?? 0);
          if (teacher != null) {
            CacheHelper.saveData(
                key: favTeacher, value: jsonEncode(teacher.toJson()));
          }
        }
      }
      print('Save done ${user.username}');
    } catch (e) {
      print('Save data error $e');
    }
  }

  Future<void> userLogOut() async {
    emit(LogOutLoadingState());
    await Auth().logOut().then((value) {
      CacheHelper.clearData(key: 'token');
      token = '';
      isLogin = false;
      changeIsLogin(islog: false);
      print('LogOut Done');
      emit(LogOutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LogOutErrorState(error.toString()));
      return error;
    });
  }

  Future<void> changeIsLogin({bool? islog}) async {
    if (token.isEmpty || token == '' || islog == false) {
      isLogin = false;
      emit(ChangeIsLogInFalseStateState());
      print('Is Login Booooooooooool $isLogin');
    } else {
      isLogin = true;
      emit(ChangeIsLogInTrueStateState());
      print('Is Login Booooooooooool $isLogin');
    }
  }
}
