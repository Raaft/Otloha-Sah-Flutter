import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';

import 'package:flutter_base/modules/messages/presentation/widgets/general_message_item.dart';

class RecitationItem extends StatelessWidget {
  const RecitationItem({
    Key? key,
    required this.generalMessageItem,
    required this.showPopup,
  }) : super(key: key);

  final GeneralMessageItem generalMessageItem;
  final Function() showPopup;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        generalMessageItem,
        Align(
            alignment: isEn ? Alignment.topRight : Alignment.topLeft,
            child: IconButton(
                onPressed: showPopup, icon: const Icon(Icons.more_vert)))
      ],
    );
  }
}
