import 'package:flutter/material.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/alert_dialog_full_screen.dart';
import 'package:flutter_base/core/widgets/loading.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/quran/presentation/widget/item_download.dart';
import 'package:flutter_base/modules/settings/business_logic/cubit/narration_cubit.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quran_widget_flutter/model/narration.dart';

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
      title: 'Narrations Center',
    );
  }

  Widget _viewItems() {
    return BlocBuilder<NarrationCubit, NarrationState>(
      builder: (context, state) {
        if (state is NarrationFetched) {
          _selected = state.selected;
          return _viewData(state.narrations);
        } else if (state is NarrationInitial) {
          return const LoadingWidget();
        } else {
          return _viewError(state);
        }
      },
    );
  }

  Expanded _viewData(List<Narration> narrations) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: narrations.length,
          itemBuilder: (context, index) {
            return ItemDownload(
              name: narrations[index].name.toString(),
              surah: narrations[index].description.toString(),
              isDownloaded: true,
              isSelect: _selected == index,
              action: () {
                Get.dialog(
                  const AlertDialogFullScreen(),
                  barrierColor: AppColor.backdone,
                );
                CacheHelper.saveData(
                    key: 'NarrationsSelected', value: narrations[index].id);
                CacheHelper.saveData(
                    key: 'NarrationsSelectedName',
                    value: narrations[index].name);
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

  Widget _viewError(NarrationState state) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppIcons.emptyIcon,
              height: 150,
              width: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextView(
                  text:
                      'No Data to Fetch! Error is ${(state as NarrationError).error}'),
            ),
          ],
        ),
      ),
    );
  }
}
