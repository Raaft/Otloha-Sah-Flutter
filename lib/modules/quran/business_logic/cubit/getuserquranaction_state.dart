part of 'getuserquranaction_cubit.dart';

abstract class GetUserQuranActionState {
  const GetUserQuranActionState();
}

class GetUserQuranActionInitial extends GetUserQuranActionState {}
class NoteSearched extends GetUserQuranActionState {}
class NoteSearchError extends GetUserQuranActionState {}

class GetUserQuranActionError extends GetUserQuranActionState {
  final String error;

  const GetUserQuranActionError({
    required this.error,
  });
}

class GetUserQuranActionNotes extends GetUserQuranActionState {
  final List<VerseNote> verses;

  const GetUserQuranActionNotes({
    required this.verses,
  });
}

class UpdateUserQuranActionNotes extends GetUserQuranActionState {}
class EditeUpdateUserQuranActionNotes extends GetUserQuranActionState {}

class IsUpdateNoteChange extends GetUserQuranActionState {}

class DeleteUserQuranActionNotes extends GetUserQuranActionState {}
class DeleteUserQuranActionBookMark extends GetUserQuranActionState {}
class DeleteUserQuranActionBookMarkError extends GetUserQuranActionState {}

class GetUserQuranActionLikeds extends GetUserQuranActionState {
  final List<VerseLiked> verses;

  const GetUserQuranActionLikeds({
    required this.verses,
  });
}

class GetUserQuranActionMarks extends GetUserQuranActionState {
  final List<PageMarked> pages;

  const GetUserQuranActionMarks({
    required this.pages,
  });
}
