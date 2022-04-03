import 'package:flutter/material.dart';
import '../../../../../data_source/cache_helper.dart';
import '../../../../../core/utils/constant/constants.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/alert_dialog_full_screen.dart';
import '../../../../../data_source/models/setting_model/init_data.dart';
import '../../widgets/item_download.dart';
import '../../../business_logic/language/language_cubit.dart';
import '../../widgets/search_bar_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../data_source/enums/download_types.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({Key? key}) : super(key: key);

  static const routeName = '/settings/languages';

  @override
  _LanguagesPageState createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    try {
      setState(() async {
        _selected =
            (await CacheHelper.getData(key: 'LanguagesSelected') as int?) ?? 0;
      });
      print('value===========> $_selected');
    } catch (e) {
      debugPrint('Langgggggggggggggg error========> ' + e.toString());
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
      title: 'Languages Center',
    );
  }

  Expanded _viewItems() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: lang.length,
          itemBuilder: (ctx, index) {
            return _builder(index);
          },
        ),
      ),
    );
  }

  Widget _builder(int index) {
    return ItemDownload(
      // index: index,
      instance: lang[index],
      downloadType: DownloadTypes.page,
      name: lang[index].langName,
      isDownloaded: true,
      isSelect: _selected == index,
      action: () {
        try {
          Get.dialog(
            const AlertDialogFullScreen(),
            barrierColor: AppColor.backdone,
          );
          CacheHelper.saveData(key: languagesSelectedId, value: index);

          CacheHelper.saveData(
              key: languagesSelectedName, value: lang[index].langName);
          setState(() {
            _selected = index;

            if (index == 0) {
              isEn = true;
            } else {
              isEn = false;
            }
          });
          settings[2].subTitle = lang[index].langName;
          BlocProvider.of<LanguageCubit>(context).changeLan(isEn, context);

          print(index.toString() + '  ' + (isEn ? 'en' : 'ar'));
        } catch (e) {
          printError(info: e.toString());
        }
      },
    );
  }
}
