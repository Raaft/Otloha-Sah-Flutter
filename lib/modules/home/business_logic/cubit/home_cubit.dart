import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  changeIndex(int? index) {
    emit(HomeInitial());
    debugPrint('index $index');
    emit(HomeChangeIndex(index ?? 0));
  }

  bool isLiked = false;
  bool isBookmarked = false;
  bool isOnPressed = false;
  bool isRecorded = false;
  bool isRecordedFile = false;

  changeIsLiked() {
    if (isLiked == false) {
      isLiked = true;
      emit(IsLikedTrueState());
    } else {
      isLiked = false;
      emit(IsLikedFalseState());
    }
  }

  changeIsBookmarked() {
    if (isBookmarked == false) {
      isBookmarked = true;
      emit(IsBookMarkTrueState());
    } else {
      isBookmarked = false;
      emit(IsBookMarkFalseState());
    }
  }

  changeIsOnPressed() {
    isOnPressed = true;
    isRecordedFile = false;
    isRecorded = true;
    emit(IsOnPressState());
  }

  changeIsRecorded() {
    isOnPressed = false;
    isRecordedFile = false;
    isRecorded = true;
    emit(IsRecordedState());
  }

   changeIsRecordedFile() {
    isOnPressed = false;
    isRecorded = false;
    isRecordedFile = true;
    emit(IsRecordedFileState());
  }

/*
  getHasRecord() async {
    bool hasPermission = await RecordPlatform.instance.hasPermission();
    emit(RecordHasPermission(hasPermission: hasPermission));
  }

  getPlayRecord() async {
    var root = await getTemporaryDirectory();
    await RecordPlatform.instance.start(
      path: root.path + '/record.m4a',
      encoder: AudioEncoder.AAC,
    );
    var isPlay = await RecordPlatform.instance.isRecording();

    emit(RecordIsRecord(isRecord: isPlay));
  }*/

}