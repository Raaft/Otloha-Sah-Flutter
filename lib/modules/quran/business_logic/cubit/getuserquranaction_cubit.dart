import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_base/modules/data/repository/database_repository.dart';
import 'package:flutter_base/modules/data/model/page_marked.dart';
import 'package:flutter_base/modules/data/model/verse_like.dart';
import 'package:flutter_base/modules/data/model/verse_note.dart';

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
