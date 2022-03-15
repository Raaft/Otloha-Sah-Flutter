import 'package:flutter/material.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/mesage_detalis_widget.dart';

class MessageDetails extends StatelessWidget {
  const MessageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          MessageDetailsHead(userName: 'Raaft', rate: '5', userId: '20', userbio: 'userbio', action: (){}, typeView: false)
        ]),
      ),
    );
  }
}
