import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constant/utils.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/text_view.dart';
import '../../../../../core/widgets/tool_bar_app.dart';
import '../../../business_logic/cubit/messagetap_cubit.dart';
import '../messages_pages/general_box.dart';
import '../messages_pages/in_box_message_page.dart';
import '../messages_pages/out_box_message_page.dart';
import '../messages_pages/private_message_page.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);
  static const routeName = '/message';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<MessageTapCubit, MessageTapState>(
          builder: (context, state) {
        var cubit = MessageTapCubit.get(context);
        int selected = cubit.index;
        return Column(
          children: [
            _topView(context),
            tabsView(context, selected, cubit),
            _viewItems(selected),
          ],
        );
      })),
    );
  }
}

Widget _viewItems(selected) {
  if (selected == 0) {
    return const GeneralMessagePage();
  }
  if (selected == 1) {
    return InBoxMessagePage();
  }
  if (selected == 2) {
    return OutBoxMessagePage();
  }
  if (selected == 3) {
    return const PrivateMessagePage();
  }
  return const GeneralMessagePage();
}

Widget _topView(context) {
  return ToolBarApp(
    backIcon: IconButton(
      icon: GestureDetector(
        child: const Icon(Icons.arrow_back),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    title: translate('Messages'),
  );
}

SizedBox _divider() {
  return SizedBox(
    width: 1.5,
    child: Divider(
      thickness: 16,
      color: AppColor.txtColor4,
    ),
  );
}

tabsView(context, selected, MessageTapCubit cubit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      tabItem(context, 'General', 0, isSelect: selected == 0, fetchData: () {
        cubit.getGeneraBoXMessage();
      }, cubit: cubit),
      _divider(),
      tabItem(context, 'Inbox', 1, isSelect: selected == 1, fetchData: () {
        cubit.getRecieveMessage();
      }, cubit: cubit),
      _divider(),
      tabItem(context, 'Outbox', 2, isSelect: selected == 2, fetchData: () {
        cubit.getSendMessage();
      }, cubit: cubit),
    ],
  );
}

tabItem(context, String title, int value,
    {bool isSelect = false,
    Function()? fetchData,
    required MessageTapCubit cubit}) {
  return GestureDetector(
    onTap: () {
      cubit.changeIndex(value);
      fetchData!();
    },
    child: Container(
      decoration: isSelect
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.gradient5, AppColor.gradient6],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.circular(5),
            )
          : null,
      child: TextView(
        text: translate(title),
        colorText: isSelect ? AppColor.txtColor2 : AppColor.txtColor4,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        sizeText: 16,
        weightText: FontWeight.w600,
      ),
    ),
  );
}
