import 'package:bloc/bloc.dart';
import '../../../../data_source/cache_helper.dart';
import '../../../../core/utils/constant/constants.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/alert_dialog_full_screen.dart';
import '../../../../data_source/models/setting_model/init_data.dart';
import 'package:get/get.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  List<Book>? books;
  int? selected;

  BookCubit() : super(BookInitial());

  changeIndex(int index) {
    selected = index;
    print(selected);

    Get.dialog(
      const AlertDialogFullScreen(),
      barrierColor: AppColor.backdone,
    );
    CacheHelper.saveData(key: bookSelectedId, value: books![index].id);

    downLoadSettings[0].subTitle = books![index].name;

    CacheHelper.saveData(
      key: bookSelectedName,
      value: books![index].name,
    );

    emit(BookFetched(books, index));
  }

  fetchBooksList({String? qurey}) {
    try {
      int? narrationId = CacheHelper.getData(key: narrationSelectedId) as int?;
      DataSource.instance
          .fetchBooksList(qurey: qurey, narrationId: narrationId)
          .then((value) async {
        print(value);

        if (value!.isNotEmpty) {
          int val = (CacheHelper.getData(key: bookSelectedId) as int?) ?? -1;
          for (var element in value) {
            if (element.id == val) {
              val = value.indexOf(element);
              downLoadSettings[0].subTitle = element.name;
              break;
            }
          }

          books = value;
          selected = val;

          emit(BookFetched(value, val));
        } else {
          emit(const BookError('Not Found Data'));
        }
      });
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }
}
