import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/constant/constants.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  changeLan(bool isEnC, BuildContext context) {
    context.setLocale(Locale(isEnC ? 'en' : 'ar'));
    isEn = isEnC;
    if (isEn) {
      EasyLocalization.of(context)!.setLocale(const Locale('en'));
      Get.updateLocale(const Locale('en')); //   Restart.restartApp();
    } else {
      EasyLocalization.of(context)!.setLocale(const Locale('ar'));
      Get.updateLocale(const Locale('ar')); //   Restart.restartApp();
    }
    emit(LanguageChange());
  }
}
