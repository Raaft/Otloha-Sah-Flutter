import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/text_view.dart';

import '../../../business_logic/cubit/messagedetails_cubit.dart';

import '../../../../settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constant/utils.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/tool_bar_app.dart';
import '../../../business_logic/cubit/reply_cubit.dart';
import '../../widgets/selectable_message_item.dart';
import 'package:intl/intl.dart';

import '../../../../../data_source/models/message_model/error_type.dart';
import '../../../../../data_source/models/message_model/message_delails.dart';

class ReplayMessagePage extends StatefulWidget {
  const ReplayMessagePage({
    Key? key,
    required this.recitationId,
    required this.msgId,
    this.parentId,
  }) : super(key: key);

  final int recitationId;
  final int msgId;
  final int? parentId;

  @override
  State<ReplayMessagePage> createState() => _ReplayMessagePageState();
}

class _ReplayMessagePageState extends State<ReplayMessagePage> {
  MessagedetailsCubit? cubit;
  ReplyCubit? replyCubit;
  String? text;
  ErrorType? errorType;
  @override
  void initState() {
    super.initState();
    cubit = MessagedetailsCubit.get(context);
    replyCubit = ReplyCubit.get(context);
    cubit!.fetchMessages(widget.msgId, widget.recitationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _topView(context),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _messageDetails(context),
            ),
            _textView(),
            //_messageField(),
          ],
        ),
      ),
    );
  }

  _messageDetails(BuildContext context) {
    return BlocBuilder<MessagedetailsCubit, MessagedetailsState>(
      builder: (context, state) {
        if (state is MessageFetchedState) {
          replyCubit!.setAyah(cubit!.ayah);
          return _viewBody(cubit!.messageDetails);
        }
        if (state is MessageLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const ViewError(error: 'Not Found Data');
      },
    );
  }

  Widget _viewBody(MessageDelails? messageDetails) {
    return Column(
      children: [
        SelectableMessageItem(
          ayah: cubit!.ayah,
          ayahInfo: _getAyahInfo(messageDetails!.recitation),
          userImage: messageDetails.recitation!.owner!.image ?? '',
          userName: _user(messageDetails.recitation!.owner),
          dateStr: (cubit!.messageDetails!.recitation!.finishedAt != null)
              ? DateFormat('hh:mm dd MMM').format(DateTime.parse(
                  cubit!.messageDetails!.recitation!.finishedAt ?? ''))
              : null,
          color: AppColor.selectColor1, isRead: false, isCertic: false,
          selectedText: (txt) {
            String select = replyCubit!.ayahText!
                .substring(txt.baseOffset, txt.extentOffset);

            setState(() {
              text = select;
            });
            print('Seleceted Text $select');
          },
          userInfo: cubit!.messageDetails!.recitation!.owner!.level! +
              ' ' +
              ((cubit!.messageDetails!.recitation!.owner!.isATeacher ?? false)
                  ? translate('Teacher')
                  : translate('Student')),
          // overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _getAyahInfo(Recitation? recitation) {
    String? str =
        '???????? ${recitation!.chapterId ?? 0} ???? ?????? ${recitation.verseIds![0]} ?????? ?????? ${recitation.verseIds![recitation.verseIds!.length - 1]}';
    return str;
  }

  String _user(Owner? owner) {
    if (owner != null) {
      var str = (owner.lastName!.isEmpty && owner.firstName!.isEmpty)
          ? (owner.username)
          : '';
      return (owner.firstName ?? '') +
          ' ' +
          (owner.lastName ?? '') +
          (str ?? '');
    } else {
      return '';
    }
  }

  Widget _topView(BuildContext context) {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: translate('?????????? ?????????? ????????'),
    );
  }

  _textView() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: (replyCubit != null && replyCubit!.errorType != null)
                    ? (replyCubit!.errorType!.value ?? tr('Choose a Error Type'))
                    : tr('Choose a Error Type'),
                sizeText: 16,
                colorText: AppColor.txtColor4,
                textAlign: TextAlign.start,
              ),
              DropdownButton<ErrorType>(
                  underline: Container(
                    height: 0,
                  ),
                  // value: (replyCubit != null) ? replyCubit!.errorType : null,
                  items: ErrorType.errors.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: TextView(
                        text: e.value ?? '',
                        sizeText: 16,
                        colorText: AppColor.txtColor4,
                        textAlign: TextAlign.start,
                      ),
                    );
                  }).toList(),
                  onChanged: (errorType) {
                    setState(() {
                      this.errorType = errorType;
                    });
                    replyCubit!.setErrorType(errorType);
                  }),
            ],
          )
        ],
      ),
    );
  }
}
