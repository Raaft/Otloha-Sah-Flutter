import 'package:bloc/bloc.dart';
import 'package:flutter_base/data_source/data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../data_source/models/home_models/user_profile.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  ProfilePageCubit() : super(ProfilePageInitial());

  static ProfilePageCubit get(context) =>
      BlocProvider.of<ProfilePageCubit>(context);

  UserProfile? currentUserProfile;

  Future<void> userProfile() async {
    emit(GetProfilePageLoading());

      AppDataSource().myProfile().then((value) {
        currentUserProfile = value;
        print('res is ==============> $value');
        emit(GetProfilePageSuccess());

      }).catchError((error){
        if (error is AuthError) {
          print('from AuthError ');

          emit(NoAuthState());
          return;
        }
        print(error);
        emit(GetProfilePageError());
      });
    }

}
