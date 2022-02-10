import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);


  changeIndex(int? index) {
    emit(HomeInitial());
    debugPrint('index $index');
    emit(HomeChangeIndex(index ?? 0));
  }

bool isLiked=false;
bool isBookmarked=false;
bool isOnBressed=false;
bool isRecorded=false;

changeIsLiked(){
  isLiked=true;
  emit(IsLikedState());
}
changeIsBookmarked(){
  isBookmarked=true;
  emit(IsBookMarkState());
}
changeIsOnBressed(){
  isOnBressed=true;
  emit(IsOnPressState());
}
changeIsRecorded(){
  isOnBressed=false;
  isRecorded=true;
  emit(IsRecordedState());
}


}
