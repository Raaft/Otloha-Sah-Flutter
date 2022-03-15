import 'package:flutter/material.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/mesage_detalails_record.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/mesage_detalis_head.dart';

import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/text_view.dart';

class MessageDetails extends StatelessWidget {
  const MessageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
      //  crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          messageDetails(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextView(
              text: 'Replays ...',
              weightText: FontWeight.bold,
              padding: const EdgeInsets.all(2),
              sizeText: 15,
              colorText: AppColor.darkBlue,
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap:true ,
            itemCount: 5,
            itemBuilder: (context, index) => messageReplay(),
          )
        ],
      ),
    );
  }

  Column messageDetails() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 50),
      MessageDetailsHead(
        userName: 'Raaft',
        verText:
            'Text of messageText of messageText of messageText of messageText of messageText of message',
        action: () {},
        typeView: true,
        isCertified: true,
      ),
    ]);
  }

  Widget messageReplay() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(),
      MessageDetailsReplay(
        userName: 'Shady',
        verText: 'Text of messageText of messageT',
        action: () {},
        isCertified: true,
      ),
      const MessageDetailsRecord(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextView(
            text: 'Comment',
            padding: const EdgeInsets.all(0),
            sizeText: 16,
            colorText: AppColor.txtColor4,
            weightText: FontWeight.w600,
            textAlign: TextAlign.center,
            //overflow: TextOverflow.ellipsis,
          ),
          TextView(
            text: 'Add Replay',
            padding: const EdgeInsets.all(0),
            sizeText: 15,
            colorText: AppColor.darkBlue,
            weightText: FontWeight.w600,
            textAlign: TextAlign.center,
            action: () {},
            //overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ]);
  }
}
