import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/res/icons_app.dart';
import '../../../../../core/widgets/text_view.dart';
import '../../../../../data_source/cache_helper.dart';
import '../../../../../core/utils/constant/constants.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/alert_dialog_full_screen.dart';
import '../../../../../data_source/models/setting_model/init_data.dart';

import '../../../business_logic/quraan_translation_cubit/quran_translation_cubit.dart';
import '../../../business_logic/quraan_translation_cubit/quran_translation_state.dart';
import '../../widgets/item_download.dart';
import '../../widgets/search_bar_app.dart';
import 'package:get/get.dart';

import '../../../../../data_source/enums/download_types.dart';

class QuranTranslationLanguagePage extends StatefulWidget {
  const QuranTranslationLanguagePage({Key? key}) : super(key: key);

  static const routeName = '/settings/quranTranslationLanguage';

  @override
  _QuranTranslationLanguagePageState createState() =>
      _QuranTranslationLanguagePageState();
}

class _QuranTranslationLanguagePageState
    extends State<QuranTranslationLanguagePage> {
  int _selected = -1;

  @override
  void initState() {

    BlocProvider.of<QuranTranslationCubit>(context).fetchTranslationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      _selected = (CacheHelper.getData(key: qtlSelectedId) as int?) ?? -1;
    } catch (e) {
      debugPrint(e.toString());
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [_topView(), _viewItems()],
        ),
      ),
    );
  }

  Widget _topView() {
    return SearchBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: tr('Quran Translation Language Center'),
    );
  }

  Expanded _viewItems() {
    return Expanded(
      child: BlocBuilder<QuranTranslationCubit, QuranTranslationState>(
        builder: (context, state) {

          var cubit= BlocProvider.of<QuranTranslationCubit>(context);
          if(state is QuranTranslationFetched)  {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.translation.length,
                itemBuilder: (context, index) {
                  return ItemDownload(
                    instance: null,
                    downloadType: DownloadTypes.page,
                    name: tr('Quran Translation Language')+ '${index + 1}',
                    description: 'surah',
                    isDownloaded: true,
                    isSelect: _selected == index,
                    action: () {
                      Get.dialog(
                        const AlertDialogFullScreen(),
                        barrierColor: AppColor.backdone,
                      );
                      CacheHelper.saveData(key: qtlSelectedId, value: index);

                      settings[3].subTitle = 'Quran Translation ${index + 1}';
                      CacheHelper.saveData(
                          key: qtlSelectedName,
                          value: 'Quran Translation ${index + 1}');
                      setState(() {
                        _selected = index;
                      });
                    },
                  );
                },
              ),
            );
          }
          if(state is QuranTranslationEmpty)  {
            return         Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppIcons.addIcon,
                    height: 150,
                    width: 150,
                  ),
                   TextView(text: tr('No Data go to Add First')),
                ],
              ),
            );

          }
          else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppIcons.addIcon,
                    height: 150,
                    width: 150,
                  ),
                  const TextView(text: 'No Data go to Add First!'),
                ],
              ),
            );

          }
        },
      ),
    );
  }
}
