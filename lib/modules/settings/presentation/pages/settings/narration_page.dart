import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../data_source/models/setting_model/init_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

import '../../../../../data_source/cache_helper.dart';
import '../../../../../core/utils/constant/constants.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/alert_dialog_full_screen.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../business_logic/narration/narration_cubit.dart';
import '../../widgets/item_download.dart';
import '../../widgets/search_bar_app.dart';
import '../../widgets/view_error.dart';

import '../../../../../data_source/enums/download_types.dart';

class NarrationPage extends StatefulWidget {
  const NarrationPage({Key? key}) : super(key: key);

  static const routeName = '/settings/narration';

  @override
  State<NarrationPage> createState() => _NarrationPageState();
}

class _NarrationPageState extends State<NarrationPage> {
  int _selected = -1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NarrationCubit>(context).fetchNarration();
  }

  @override
  Widget build(BuildContext context) {
    try {
      _selected = (CacheHelper.getData(key: narrationSelectedId) as int?) ?? -1;
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
      title: tr('Narrations Center'),
      onSearch: (val) {
        BlocProvider.of<NarrationCubit>(context).fetchNarration(qurey: val);
      },
    );
  }

  Widget _viewItems() {
    return BlocBuilder<NarrationCubit, NarrationState>(
      builder: (context, state) {
        if (state is NarrationFetched) {
          _selected = state.selected;
          return _viewData(state.narrations);
        }
        if (state is NarrationChangeSelected) {
          _selected = state.selected;
          return _viewData(state.narrations);
        } else if (state is NarrationInitial) {
          return const LoadingWidget();
        } else {
          String error = 'Not Found Data';

          if (state is NarrationError) {
            error = state.error;
          }

          return ViewError(error: error);
        }
      },
    );
  }

  Expanded _viewData(List<Narration>? narrations, {bool isDemo = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: isDemo ? 15 : narrations!.length,
          itemBuilder: (context, index) {
            return ItemDownload(
              instance: narrations![index],
              downloadType: DownloadTypes.page,
              name: isDemo
                  ? tr('narrations name')
                  : narrations[index].name.toString(),
              description: isDemo
                  ? tr('narrations description')
                  : narrations[index].description.toString(),
              isDownloaded: true,
              isSelect: _selected == index,
              action: () {
                BlocProvider.of<NarrationCubit>(context).changeIndex(index);

                Get.dialog(
                  const AlertDialogFullScreen(),
                  barrierColor: AppColor.backdone,
                );
                CacheHelper.saveData(
                  key: narrationSelectedId,
                  value: isDemo ? index : narrations[index].id,
                );
                CacheHelper.clearData(key: bookSelectedId);
                CacheHelper.clearData(key: reciterSelectedId);
                CacheHelper.clearData(key: bookSelectedName);
                CacheHelper.clearData(key: reciterSelectedName);
                settings[1].subTitle = '';
                downLoadSettings[0].subTitle = '';
                settings[0].subTitle =
                    isDemo ? 'narrations name $index' : narrations[index].name;
                CacheHelper.saveData(
                  key: narrationSelectedName,
                  value: isDemo ? 'narrations name' : narrations[index].name,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
