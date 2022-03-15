import 'package:flutter/material.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/mesage_detalails_record.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/mesage_detalis_head.dart';

class MessageDetails extends StatelessWidget {
  const MessageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          MessageDetailsHead(
            userName: 'Raaft',

            verText: 'Text of messageText of messageText of messageText of messageText of messageText of message',
            action: () {},
            typeView: true,
          isCertified: true,
          ),
          const MessageDetailsRecord(),
        ]),
      ),
    );
  }
}
