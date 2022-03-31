import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/data_source/data_source.dart';
import 'package:flutter_base/data_source/models/message_model/general_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'genaralmessage_state.dart';

class GenaralmessageCubit extends Cubit<GenaralmessageState> {
  GenaralmessageCubit() : super(GenaralmessageInitial());

  List<GeneralResponse>? generalResponses;
  static GenaralmessageCubit get(context) => BlocProvider.of(context);

  getGeneraBoXMessage() async {
    emit(GenaralLoadingState());
    AppDataSource().getGeneraBoXMessage().then((value) async {
      generalResponses = value;

      print('UserRecitation is ===========> $generalResponses');
      emit(GenaralSuccessState());
      if (generalResponses!.isEmpty) {
        emit(GenaralErrorState(EmptyListException()));
      }
    }).catchError((error) {
      print('Error G ' + error.toString());
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(GenaralErrorState(error));
    });
  }

  fetchNextPage(int next) async {
    return await ApiBaseHelper().getHTTP('$baseUrl/api/v1/recitations/general/',
        queryParameters: {'page': next});
  }
}
