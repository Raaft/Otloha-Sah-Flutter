import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data_source/local/database/database_repository.dart';
import '../../../../data_source/models/database_model/page_marked.dart';
import '../../../../data_source/models/database_model/verse_like.dart';
import '../../../../data_source/models/database_model/verse_note.dart';

part 'getuserquranaction_state.dart';

class GetUserQuranActionCubit extends Cubit<GetUserQuranActionState> {
  DatabaseRepository databaseRepository;

  GetUserQuranActionCubit(
    this.databaseRepository,
  ) : super(GetUserQuranActionInitial());

  static GetUserQuranActionCubit get(context) =>
      BlocProvider.of<GetUserQuranActionCubit>(context);

  Future findAllVerseNotes() async {
    databaseRepository.findAllVerseNotes()!.then((value) {
      if (value != null && value.isNotEmpty) {
        emit(GetUserQuranActionNotes(verses: value));
      } else {
        emit(const GetUserQuranActionError(error: 'Not Found Items'));
      }
      print('Entity Bloc ' + value.toString());
    });
  }

  Future<void> updateVerseNotes(VerseNote verseNote, String textUpdated) async {
    verseNote.noteText = textUpdated;

    /// emit(EditeUpdateUserQuranActionNotes());
    databaseRepository.updateVerseNote(verseNote)!.then((value) {
      if (value != null && value.isNotEmpty) {
        ///findAllVerseNotes();

        emit(UpdateUserQuranActionNotes());
      } else {
        emit(const GetUserQuranActionError(error: 'Not Found Items'));
      }
      print('Entity Bloc ' + value.toString());
    });
  }

  deleteVerseNotes(int id) {
    databaseRepository.deleteVerseNote(id)!.then((value) {
      findAllVerseNotes();
      if (value != null && value.isNotEmpty) {
        emit(DeleteUserQuranActionNotes());
      } else {
        emit(const GetUserQuranActionError(error: 'Not Found Items'));
      }
      print('Entity Bloc ' + value.toString());
    });
  }

  bool isUpdateNote = false;

  findAllVerseLikeds() {
    databaseRepository.findAllVerseLikeds()!.then((value) {
      if (value != null && value!.isNotEmpty) {
        emit(GetUserQuranActionLikeds(verses: value));
      } else {
        emit(const GetUserQuranActionError(error: 'Not Found Items'));
      }
      print('Entity Bloc ' + value.toString());
    });
  }

  findAllPageMarkeds() {
    databaseRepository.findAllPageMarkeds()!.then((value) {
      if (value != null && value!.isNotEmpty) {
        emit(GetUserQuranActionMarks(pages: value));
      } else {
        emit(const GetUserQuranActionError(error: 'Not Found Items'));
      }
      print('Entity Bloc ' + value.toString());
    });
  }

  deleteVerseBookMark(int id) {
    databaseRepository.deletePageMarked(id)!.then((value) {
      findAllPageMarkeds();
      if (value != null && value.isNotEmpty) {
        emit(DeleteUserQuranActionBookMark());
      } else {
        emit(DeleteUserQuranActionBookMarkError());
      }
      print('Entity Bloc ' + value.toString());
    });
  }
}
