import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
class RecordTool extends StatelessWidget {
  const RecordTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      width: MediaQuery
          .of(context)
          .size
          .width / 1.15,

      alignment: Alignment.center,
      height: 60,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 5.0)
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 1.1],
          colors: [AppColor.darkBlue, AppColor.lightBlue],
        ),
        color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "00:3",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.lightYellow,
                fontSize:20
            ),
          ),
          GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.mic_none,
                color: AppColor.lightYellow,
                size: 40,
              )),

          GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.pause_circle_outline,
                color: AppColor.white,
                size: 40,
              )),
          GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.fact_check_outlined,
                color: AppColor.white,
                size: 40,
              )),

        ],
      ),
    ) ;
  }
}
