import 'package:flutter/material.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/alert_dialog_full_screen.dart';
import 'package:flutter_base/core/widgets/loading.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/item_download.dart';
import 'package:flutter_base/modules/settings/business_logic/reciter/reciter_cubit.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quran_widget_flutter/model/reciter.dart';

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
      _selected = (CacheHelper.getData(key: 'ReciterSelected') as int?) ?? -1;
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
          return _viewData(
            null,
            isDemo: true,
          );
        }
      },
    );
  }

  Widget _viewData(List<Reciter>? reciters, {bool isDemo = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return ItemDownload(
              name: isDemo ? 'reciters name' : reciters![index].name.toString(),
              isDownloaded: true,
              isSelect: _selected == index,
              action: () {
                Get.dialog(
                  const AlertDialogFullScreen(),
                  barrierColor: AppColor.backdone,
                );
                CacheHelper.saveData(
                  key: 'ReciterSelected',
                  value: isDemo ? index : reciters![index].id,
                );
                settings[2].subTitle =
                    isDemo ? 'reciters name $index' : reciters![index].name;

                CacheHelper.saveData(
                  key: 'ReciterSelectedName',
                  value: isDemo ? 'reciters name' : reciters![index].name,
                );

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
