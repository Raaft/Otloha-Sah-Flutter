import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/item_setting.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/item_setting_sub.dart';

import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shrinkWrap: true,
          children: [
            _topView(context),
            _mainSettings(context),
            //  setting(context),
            Divider(),
            SizedBox(
              width: double.infinity,
              child: TextView(
                text: translate('Download Center'),
                colorText: AppColor.txtColor3,
                sizeText: 16,
                weightText: FontWeight.w700,
                padding: const EdgeInsets.all(4),
                textAlign: TextAlign.start,
              ),
            ),
            _downloadSettings(context),

          ],
        ),
      ),
    );
  }

  Widget _topView(BuildContext context) {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: translate('Settings'),
    );
  }

  _mainSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: settings.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 2 / 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          return ItemSetting(settings: settings[index]);
        },
      ),
    );
  }
  _downloadSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dawnLoadSettings.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 2 / 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          return ItemSetting(settings: dawnLoadSettings[index]);
        },
      ),
    );
  }

  setting(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: settings.length,
      itemBuilder: (context, index) {
        return ItemSubSetting(settings: settings[index]);
      },
    );
  }
}
