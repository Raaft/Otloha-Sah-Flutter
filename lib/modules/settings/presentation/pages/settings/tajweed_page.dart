import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/modules/settings/business_logic/tajweed/tajweed_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/res/icons_app.dart';
import '../../../../../core/widgets/text_view.dart';
import '../../../../../data_source/cache_helper.dart';
import '../../../../../core/utils/constant/constants.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/alert_dialog_full_screen.dart';
import '../../../../../data_source/models/setting_model/init_data.dart';
import '../../widgets/item_download.dart';
import '../../widgets/search_bar_app.dart';
import 'package:get/get.dart';

import '../../../../../data_source/enums/download_types.dart';

class TajweedPage extends StatefulWidget {
  const TajweedPage({Key? key}) : super(key: key);
  static const routeName = '/settings/tajweed';

  @override
  State<TajweedPage> createState() => _TajweedPageState();
}

class _TajweedPageState extends State<TajweedPage> {
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
      title: 'Books Center',
    );
  }

  _viewItems() {
    return Expanded(
      child: BlocConsumer<TajweedCubit, TajweedState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is TajweedFetched) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.tajweed.length,
                itemBuilder: (context, index) {
                  return ItemDownload(
                    instance: Null,
                    downloadType: DownloadTypes.page,
                    name: tr('Tajweed Name')+'${index + 1}',
                    description: tr('Sourah'),
                    isDownloaded: true,
                    isSelect: _selected == index,
                    action: () {
                      Get.dialog(
                        const AlertDialogFullScreen(),
                        barrierColor: AppColor.backdone,
                      );
                      CacheHelper.saveData(
                          key: tafseerSelectedId, value: index);

                      settings[5].subTitle = tr('Tajweed')+' ${index + 1}';
                      CacheHelper.saveData(
                          key: tafseerSelectedId,
                          value: tr('Tajweed Name')+' ${index + 1}');
                      setState(() {
                        _selected = index;
                      });
                    },
                  );
                },
              ),
            );
          }
          if (state is TajweedError) {
            return Center(
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
          } else {
            return Center(
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
        },
      ),
    );
  }
}
