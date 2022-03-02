import 'package:flutter/material.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/alert_dialog_full_screen.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/item_download.dart';
import 'package:flutter_base/modules/settings/business_logic/language/language_cubit.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({Key? key}) : super(key: key);

  static const routeName = '/settings/languages';
  @override
  _LanguagesPageState createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    try {
      _selected = (CacheHelper.getData(key: 'LanguagesSelected') as int?) ?? -1;
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
      name: lang[index].langName,
      isDownloaded: true,
      isSelect: _selected == index,
      action: () {
        try {
          CacheHelper.saveData(key: 'LanguagesSelected', value: index);

          CacheHelper.saveData(
              key: 'LanguagesSelectedName', value: lang[index].langName);
          setState(() {
            _selected = index;

            if (index == 0) {
              isEn = true;
            } else {
              isEn = false;
            }
          });
          settings[3].subTitle = lang[index].langName;
          BlocProvider.of<LanguageCubit>(context).changeLan(isEn, context);

          print(index.toString() + '  ' + (isEn ? 'en' : 'ar'));

          Get.dialog(
            const AlertDialogFullScreen(),
            barrierColor: AppColor.backdone,
          );
        } catch (e) {
          printError(info: e.toString());
        }
      },
    );
  }
}
