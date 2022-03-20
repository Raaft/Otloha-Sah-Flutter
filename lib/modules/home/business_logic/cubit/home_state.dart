part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class IsLikedTrueState extends HomeState {}

class IsLikedFalseState extends HomeState {}

class IsOnPressFalseState extends HomeState {}

class IsOnPressTrueState extends HomeState {}

class IsBookMarkTrueState extends HomeState {}

class IsBookMarkFalseState extends HomeState {}

class IsRecordedState extends HomeState {}

class IsRecordedFileState extends HomeState {}

class GetDurationState extends HomeState {}

class ChangeDurationState extends HomeState {}

class IsFloatingTrueMenuState extends HomeState {}
class GetChapterByIdLoadingState extends HomeState {}
class  GetChapterByIdSucssState extends HomeState {}
class GetChapterByIdErrorState extends HomeState {}

class IsFloatingFalseMenuState extends HomeState {}

class ChangeOpacityState extends HomeState {}

class ChangeIsSelectedVerseState extends HomeState {}

class ChangeIsPlayingState extends HomeState {}

class ChangePlayPauseState extends HomeState {}

class ChangePageState extends HomeState {}

class QuranChangeChapter extends HomeState {}

class CheckIsVerseEmptyState extends HomeState {}

class DoneCheckIsVerseEmptyState extends HomeState {}
class ChangeIsLogInStateState extends HomeState {}

class HomeChangeIndex extends HomeState {
  final int index;

  const HomeChangeIndex(this.index);
}

class RecordHasPermission extends HomeState {
  final bool hasPermission;
  const RecordHasPermission({
    required this.hasPermission,
  });
}

class RecordIsPlay extends HomeState {
  final bool isPlay;
  const RecordIsPlay({
    required this.isPlay,
  });
}

class RecordIsRecord extends HomeState {
  final bool isRecord;
  const RecordIsRecord({
    required this.isRecord,
  });
}
