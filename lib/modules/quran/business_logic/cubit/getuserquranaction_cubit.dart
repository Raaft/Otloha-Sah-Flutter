import 'package:bloc/bloc.dart';

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

  findAllVerseNotes() {
    databaseRepository.findAllVerseNotes()!.then((value) {
      if (value != null && value.isNotEmpty) {
        emit(GetUserQuranActionNotes(verses: value));
      } else {
        emit(const GetUserQuranActionError(error: 'Not Found Items'));
      }
      print('Entity Bloc ' + value.toString());
    });
  }

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
}
