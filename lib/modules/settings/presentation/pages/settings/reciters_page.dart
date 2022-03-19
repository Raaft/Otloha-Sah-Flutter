import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/modules/data/enums/download_types.dart';
import 'package:flutter_base/modules/settings/business_logic/recitation/recitation_cubit.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/alert_dialog_full_screen.dart';
import 'package:flutter_base/core/widgets/loading.dart';
import 'package:flutter_base/modules/settings/business_logic/reciter/reciter_cubit.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/item_download.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

class RecitersPage extends StatefulWidget {
  const RecitersPage({Key? key}) : super(key: key);

  static const routeName = '/settings/reciters';
  @override
  _RecitersPageState createState() => _RecitersPageState();
}

class _RecitersPageState extends State<RecitersPage> {
  int _selected = -1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReciterCubit>(context).fetchReciter();
  }

  @override
  Widget build(BuildContext context) {
    try {
      _selected = (CacheHelper.getData(key: reciterSelectedId) as int?) ?? -1;
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
      title: 'Reciters Center',
    );
  }

  Widget _viewItems() {
    return BlocBuilder<ReciterCubit, ReciterState>(
      builder: (context, state) {
        if (state is ReciterFetched) {
          _selected = state.selected;
          return _viewData(state.reciters);
        } else if (state is ReciterInitial) {
          return const LoadingWidget();
        } else {
          String error = 'Not Found Data';

          if (state is ReciterError) {
            error = state.error;
          }

          return ViewError(error: error);
        }
      },
    );
  }

  Widget _viewData(List<Reciter>? reciters, {bool isDemo = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: isDemo ? 15 : reciters!.length,
          itemBuilder: (context, index) {
            return ItemDownload(
              instance: null,
              downloadType: DownloadTypes.page,
              name: isDemo ? 'reciters name' : reciters![index].name.toString(),
              isDownloaded: true,
              isSelect: _selected == index,
              action: () {
                Get.dialog(
                  const AlertDialogFullScreen(),
                  barrierColor: AppColor.backdone,
                );
                CacheHelper.saveData(
                  key: reciterSelectedId,
                  value: isDemo ? index : reciters![index].id,
                );
                settings[1].subTitle =
                    isDemo ? 'reciters name $index' : reciters![index].name;

                CacheHelper.saveData(
                  key: reciterSelectedName,
                  value: isDemo ? 'reciters name' : reciters![index].name,
                );

                BlocProvider.of<RecitationCubit>(context).fetchRecitations();

                setState(() {
                  _selected = index;
                });
              },
            );
          },
        ),
      ),
    );
  }
}