import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/item_seeting.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/item_setting_sub.dart';

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
            setting(context),
            const SizedBox(
              height: 24,
            ),
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
      actionIcon: IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
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
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 1.65,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          return ItemSetting(settings: settings[index]);
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
