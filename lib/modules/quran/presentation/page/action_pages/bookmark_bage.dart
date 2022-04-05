import 'package:flutter/material.dart';
import 'package:flutter_base/modules/quran/presentation/page/action_pages/pages_liked_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constant/utils.dart';
import '../../../../../core/utils/res/icons_app.dart';
import '../../../../../core/widgets/text_view.dart';
import '../../../../../data_source/models/database_model/page_marked.dart';
import '../../../../home/presentation/pages/home/home_page.dart';
import '../../../../settings/presentation/widgets/search_bar_app.dart';
import '../../../business_logic/cubit/getuserquranaction_cubit.dart';

class PagesBookMarkPage extends StatelessWidget {
  const PagesBookMarkPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/quran/bookmark';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetUserQuranActionCubit>(context).findAllPageMarkeds();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [_topView(context), _viewItems()],
        ),
      ),
    );
  }

  Widget _topView(BuildContext context) {
    return SearchBarApp(
        backIcon: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: translate('BookMarks'));
  }

  Expanded _viewItems() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetUserQuranActionCubit, GetUserQuranActionState>(
          builder: (context, state) {
            if (state is GetUserQuranActionMarks) {
              return ListView.builder(
                itemCount: state.pages.length,
                itemBuilder: (context, index) {
                  late PageMarked page = state.pages[index];
                  return ItemBookMark(
                    index: index,
                      name: page.textVerse.toString(),
                      pageFrom: page.idPage!.toInt(),
                      pageId: page.id,
                      onPress: () {
                        Navigator.of(context).pushReplacementNamed(
                          HomePage.routeName,
                          arguments: 1,
                        );
                      });
                },
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
                    const TextView(text: 'No Data go to Add First!'),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
