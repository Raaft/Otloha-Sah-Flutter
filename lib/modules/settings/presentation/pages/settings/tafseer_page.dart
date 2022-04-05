import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data_source/cache_helper.dart';
import '../../../../../core/utils/constant/constants.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/alert_dialog_full_screen.dart';
import '../../../../../data_source/models/setting_model/init_data.dart';
import '../../../business_logic/tafseer_cubit/tafsir_cubit.dart';
import '../../widgets/item_download.dart';
import '../../widgets/search_bar_app.dart';
import 'package:get/get.dart';

import '../../../../../data_source/enums/download_types.dart';

class TafseerPage extends StatefulWidget {
  const TafseerPage({Key? key}) : super(key: key);

  static const routeName = '/settings/tafseer';

  @override
  State<TafseerPage> createState() => _TafseerPageState();
}

class _TafseerPageState extends State<TafseerPage> {
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    try {
      _selected = (CacheHelper.getData(key: tafseerSelectedId) as int?) ?? -1;
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
      title: 'Tafseer Center',
    );
  }

  Expanded _viewItems() {
    return Expanded(
      child: BlocConsumer<TafsirCubit, TafsirState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is TafsirFetched) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.Tafsir.length,
                itemBuilder: (context, index) {
                  return ItemDownload(
                    instance: null,
                    downloadType: DownloadTypes.page,
                    name: 'Tafseer ${index + 1}',
                    description: 'surah',
                    isDownloaded: true,
                    isSelect: _selected == index,
                    action: () {
                      Get.dialog(
                        const AlertDialogFullScreen(),
                        barrierColor: AppColor.backdone,
                      );
                      CacheHelper.saveData(
                          key: tafseerSelectedId, value: index);

                      settings[4].subTitle = 'Tafseer ${index + 1}';
                      CacheHelper.saveData(
                          key: tafseerSelectedName,
                          value: 'Tafseer ${index + 1}');

                      setState(() {
                        _selected = index;
                      });
                    },
                  );
                },
              ),
            );
          }
          if (state is TafsirError) {
            return Center(child: Text(tr('No Data Found')));
          } else {
            return Center(child: Text(tr('someThing Error')));
          }

        },
      ),
    );
  }
}
